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

architecture dmy of dti_spi is
  
    signal mclk_cnt  : natural range 0 to 32 := 0;
    signal shift_write : std_logic_vector (15 downto 0);  --or 16 bit 
    signal shift_write : std_logic_vector (7 downto 0);
    type spi_fsm_state_type is (IDLE, 
                                SPI_READ, 
                                SPI_WRITE);

    --variable spi_fsm_state : spi_fsm_state_type;

    signal curr_state , next_state : spi_fsm_state_type;
    
begin
  
  SPI_FSM_SEQ : process (mclk, rst) is
    
   begin

   if(rst='1')
      sclk <= '0';
      curr_state := IDLE;

   elsif (rising_edge(mclk)) then 
     mclk_cnt <= mclk_cnt + 1;
     curr_state <= next_state;

     if (mclk_cnt = 16) then    --generating clock, 1/32 of 100MHz
        sclk <= '1';
        mclk_cnt <= 0;
     else 
        sclk <= '0';
     end if;
      
     
     end if;
   end process;




 SPI_FSM_COMB : process(all) is

    variable bitcount : unsigned(2 downto 0);

    begin

    case curr_state is
        when IDLE =>
            ce <= '0';
            sdi <= '0';  --spi data output
            busy <= '0';
            
            bitcount <= 0;

            if(wr_str ='1') then
                next_state <= SPI_WRITE;
            end if ;
            
            if (rd_str = '1')
                next_state <= SPI_READ;
            end if ; --ends IDLE


        when SPI_WRITE =>
            if(rst='1')
        
            next_state := IDLE;
            
            else 
 
                ce <= '1';
                busy <= '1';
                shift_write <= instr & wdata;
            
                if(sclk ='1') then     -- MISO with spi slow clock 
                    bitcount <= bitcount+1;

                    sdi <= shift_write(15);   --value of MSB being transmitted via spi
                    shift_write <= shift_write sll 1;  --
 
                    if (bitcount = 16)then 
                        bitcount = 0;
                        next_state <= IDLE;
                    end if ;

            --counting 16 bits?
                 end if ; 

              end if ;




        when SPI_READ =>
            if(rst='1')
        
                next_state := IDLE;
            
            else 
                busy <= '1';
                ce <= '1';
                shift_write <= instr & "00000000"; --loaded register with address 8 bits 
            
                if(sclk ='1') then     -- MOSI 
                    bitcount <= bitcount+1;
                    sdi <= shift_write(15);   --value of MSB (instruction address )being transmitted via spi
                    shift_write <= shift_write sll 1;  --
                     
                    if (bitcount >= 8)then  --start reading 
                        shift_read(0) <= sdo;  --input spi data to rdatavector    
                        shift_read <= shift_read sll 1;
                    end if;
                    
                    if (bitcount = 16)then 
                        rdata <= shift_read;
            
                        bitcount = 0;
                        next_state <= IDLE;
                    end if ;
                end if ;
            end if;  

        end case;

   end process SPI_FSM_COMB;
 


end dmy;

