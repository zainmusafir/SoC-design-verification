------------ -------------------------- ---------------------------------
--
-- File	   : dti_spi_dmy.vhd
-- Project : MLA
-- Designer: roarsk
--
-- Description: SPI for MAX31723.
--   The sclk is divided by 32; i.e. 100MHz master clock gives approx 3 MHz.
--   Single byte write operation.
--
--------------------------------------------------------------------------
  
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library psif_lib;
use psif_lib.psif_pck.all;

architecture rtl of dti_spi is
    signal bitcount, bitcountnext :unsigned (4 downto 0);

    signal mclk_cnt  : unsigned (4 downto 0) := (others => '0');
    signal sclk_rising, sclk_falling  : std_logic;

    signal shift_write,shift_writenext  : std_logic_vector (15 downto 0);  --or 16 bit 
    signal shift_read , shift_readnext: std_logic_vector (7 downto 0) := (others => '0');
    type spi_fsm_state_type is (IDLE, 
                                SPI_READ, 
                                SPI_WRITE);

    --variable spi_fsm_state : spi_fsm_state_type;

    signal curr_state , next_state : spi_fsm_state_type := IDLE;
    
begin
  
  SPI_FSM_SEQ : process (mclk, rst) is
    
   begin
    
    

   if(rst = '1') then 
      sclk <= '1';
      curr_state <= IDLE;
      bitcount <= (others => '0');
      shift_write <= (others => '0');
      mclk_cnt <= (others =>'0');
      curr_state <= IDLE;
      shift_read <= (others => '0');
     -- rdata <= (others => '0');

   elsif (rising_edge(mclk)) then 
     mclk_cnt <= mclk_cnt + 1;
     curr_state <= next_state;
     shift_write <= shift_writenext; 
     bitcount <= bitcountnext;
     shift_read <= shift_readnext;


     sclk_rising <= '0';
     sclk_falling <= '0';  --next risng mclk or reset


     case curr_state is 
        when IDLE =>
        mclk_cnt <= (others =>'0');
        sclk <= '1';

        when SPI_WRITE =>

            if (mclk_cnt = "01111") then    --generating clock, 1/32 of 100MHz
                sclk <= '0';
                sclk_falling <='1';

            elsif (mclk_cnt = "00000") then
                sclk <= '1';
                sclk_rising <='1';
            end if;

            -- Keep sclk high after last bit
            sclk <= '1' when (sclk_falling = '1' and bitcount = "10000"); 
       

        when SPI_READ =>

            if (mclk_cnt = "01111" ) then    --generating clock, 1/32 of 100MHz
                sclk <= '0';
                sclk_falling <='1';
            elsif (mclk_cnt = "00000") then
                sclk <= '1';
                sclk_rising <='1';
            end if;

            -- Keep sclk high after last bit
            sclk <= '1' when (bitcount = "10001"); 


        end case;
    
     end if;
      
     
     --end if;
   end process  SPI_FSM_SEQ;




 SPI_FSM_COMB : process(all) is

    --variable bitcount : unsigned(2 downto 0);

    begin
    --bitcountnext <= bitcountnext;
    --next_state <= curr_state;
    --shift_writenext <= shift_write;
    
    case curr_state is
        when IDLE =>
            ce <= '0';
            sdi <= '0';  --spi data output
            busy <= '0';
            -- Next state default
            next_state <= IDLE;


            bitcountnext  <= (others => '0');

            if(wr_str ='1') then
                next_state <= SPI_WRITE;
                busy <= '1';
                ce <= '1';
                shift_writenext <= instr & wdata;
            end if ;
            
            if (rd_str = '1') then 
                next_state <= SPI_READ;
                busy <= '1';
                ce <= '1';
                shift_writenext <= instr & "00000000";
            end if ; --ends IDLEshift_write


        when SPI_WRITE =>
           -- if(rst='1') then 
        
              --  next_state <= IDLE;
            
           -- else 
 
                --ce <= '1';
                --busy <= '1';
                
            
                if(sclk_falling ='1') then     -- MISO with spi slow clock strobe   //ro- write data after falling edge of clk
                    bitcountnext <= bitcount + 1 ;

                    sdi <= shift_write(15);   --value of MSB being transmitted via spi
                    shift_writenext <= shift_write sll 1;  --
 
                    if (bitcount = "10000") then   --
                        next_state <= IDLE;
                    end if ;

           
                 end if ; 

              --end if ;




        when SPI_READ =>
          --  if(rst='1') then
        
              --  next_state <= IDLE;
            
           -- else 
                next_state <= SPI_READ;


                if (bitcount = "10001")then 
                    rdata <= shift_read;

                    bitcountnext <= (others => '0');
                    next_state <= IDLE;
                end if ;
                --busy <= '1';
                --ce <= '1';
                --shift_writenext <= instr & "00000000"; --loaded register with address 8 bits 
                if (sclk_falling = '1' ) then

                    bitcountnext <= bitcount + 1 ;

                    if ( bitcount < "01000") then
                    sdi <= shift_write(15);   --value of MSB (instruction address )being transmitted via spi
                    shift_writenext <= shift_write sll 1;  --
                    end if;

                end if;

                if(sclk_rising ='1') then     -- MOSI 
                    if (bitcount >= "01000")then  --start reading   
                        shift_readnext <= shift_read sll 1;
                        shift_readnext(0) <= sdo;  --input spi data to rdatavector  
                    end if;
                    
                    
                end if ;
           -- end if;  

        end case;

   end process SPI_FSM_COMB;
 


end rtl;


