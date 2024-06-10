library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library psif_lib;
use psif_lib.zu_pck.all;

architecture rtl of zu_fsm is

--signal counter : std_logic_vector(7 downto 0) := "00000000";
signal counter : unsigned(7 downto 0) := "00000000";

begin

    CLOCKKED : process (rst, mclk) is

     type zu_fsm_state_type is (IDLE, COUNT, RESULT);
     variable zu_fsm_state : zu_fsm_state_type;
        
    

    begin

      if (rst = '1') then
    
        inv_chiper_rst_n <= '0';
        inv_chiper_start_str <= '0';

        done <= '1';
        counter <= (others => '0');

        zu_tdata_cnt_str <= '0';

        zu_tdata_cnt  <="00000000";  --this ok


        zu_fsm_state := IDLE;

    

     elsif rising_edge(mclk) then 
            inv_chiper_rst_n <= '1';
            --done <= '1';
            zu_tdata_cnt_str <='0';   --defaults to zero


            case zu_fsm_state is 

                

                when IDLE =>
            
                 done <= '1';
                 counter <= (others => '0');
                 

                 zu_tdata_cnt_str <='0';

                 if (fsm_rst ='1') then
                 zu_fsm_state := IDLE;


                 else
                    if(start_str='1') then 
                        zu_tdata_cnt <= "00000000";  --reset only on new request of start str so data may be of use in the next module

                        zu_fsm_state := COUNT;
                        inv_chiper_start_str <= '1';
                    end if;

                 end if;



                when COUNT =>

                    inv_chiper_start_str <= '0';

                    if (inv_chiper_tvalid ='1' and inv_chiper_tready ='1' ) then
                        counter <= counter +1;
                        done <= '0';
                    end if;

                    if(inv_chiper_done_str = '1') then 
                        zu_tdata_cnt <= std_logic_vector(counter);
                        zu_tdata_cnt_str <='1';
                        zu_fsm_state := RESULT;
                        done <= '1';
                    
                    end if;

                      
               
                 
               


                when RESULT=>
                --write zukey data and release the inv_cipher signal
                
                --if rising_edge(mclk)  then 
                

                  done <= '1';
                  zu_tdata_cnt_str <='0'; 
                  
                  

                  zu_fsm_state := IDLE;  
                --end if;

            end case;

        
    end if; 
 end process ;






      end rtl;

