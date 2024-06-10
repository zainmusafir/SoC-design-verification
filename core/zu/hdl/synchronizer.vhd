
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity synchronizer is
port (

clk_fast : in std_logic ; --connected clk_out2
rst_125m : in std_logic ;

clk_slow : in std_logic ; --connected
rst      : in std_logic ; 

zu_str_to_sync: in std_logic; --attached to zu_tdata_cnt_str
zu_data_to_sync : in std_logic_vector(7 downto 0);  --zu_tdata_cnt

zu_tready : in std_logic; 


zu_tready_sync : out std_logic;

zu_out_slow_data : out std_logic_vector(7 downto 0);

zu_out_slow_cnt_str : out std_logic --should this?

);

end synchronizer;


architecture rtl of synchronizer is



component scu_edge_regenerator is
port (
-- Fast reset and clock signals
rst_fast : in std_logic;
clk_fast : in std_logic;
-- Fast clock strobe signal
ena_fastclk_str : in std_logic;
-- Slow reset and clock signals
rst_slow : in std_logic;
clk_slow : in std_logic;
-- Slow clock strobe signal
ena_slowclk_str : out std_logic
);
end component ;

--signals

signal slow_enable : std_logic;
attribute direct_enable : string;
attribute direct_enable of slow_enable : signal  is "yes";


signal tready_s1: std_logic;
--signal tready_r2: std_logic;



begin


edge_detect : scu_edge_regenerator
  port map(  

     rst_fast => rst_125m,
     clk_fast => clk_fast,
     ena_fastclk_str =>zu_str_to_sync,
     rst_slow => rst,
     clk_slow => clk_slow,
     ena_slowclk_str => slow_enable  --synchronised slow str signal to be taken out of the module
         );



 SYNC_DATA : process(clk_slow, rst) is 

 begin 


  if( rst = '1') then

    zu_out_slow_data <= "00000000";

    elsif(rising_edge(clk_slow)) then
    
        if(slow_enable ='1') then
            zu_out_slow_data <= zu_data_to_sync ;
        end if;
    
   
   end if;

    end process;



 SYNC_ZU_TREADY  : process (clk_fast)
   begin 
   if(rising_edge(clk_fast)) then
    
    tready_s1 <= zu_tready;
    zu_tready_sync <= tready_s1;
   -- zu_tready_sync <= tready_s2;


    end if;

   end process;



   zu_out_slow_cnt_str <= slow_enable;





     
    end rtl;




