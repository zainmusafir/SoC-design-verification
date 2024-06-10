
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library psif_lib;
use psif_lib.scu_pck.all;
use psif_lib.psif_pck.all; 

entity scu_reg is
  generic (
    -- Enable readback of write only registers
    DEBUG_READBACK      : boolean := PSIF_DEBUG_READBACK_V
    );
  
  port (
    -- Add user ports here:

    -- Add user ports end 

    -- Do not modify the ports beyond this line  

    --RegisterPorts--
    zu_data_ena             : out std_logic_vector(0 downto 0);
    dti_read_ena            : out std_logic_vector(0 downto 0);
    fsm_rst                 : out std_logic_vector(0 downto 0);
    alarm_ack_button        : in  std_logic_vector(0 downto 0);
    oledbyte3_0             : out std_logic_vector(31 downto 0);
    oledbyte7_4             : out std_logic_vector(31 downto 0);
    oledbyte11_8            : out std_logic_vector(31 downto 0);
    oledbyte15_12           : out std_logic_vector(31 downto 0);
    zu_tdata_cnt            : in  std_logic_vector(7 downto 0);
    zu_byte_cnt_error       : in  std_logic_vector(0 downto 0);
    temperature_test_ena    : out std_logic_vector(0 downto 0);
    temperature_test_digit0 : out std_logic_vector(3 downto 0);
    temperature_test_digit1 : out std_logic_vector(3 downto 0);
    
    -- Clock Signal
    pif_clk          : in std_logic;
    -- Reset Signal. This signal is active HIGH
    pif_rst          : in std_logic;
    -- Register chip select
    pif_regcs        : in std_logic; 
    -- Write address
    pif_addr         : in std_logic_vector(PSIF_ADDRESS_LENGTH-1 downto 0); 
    -- Write data 
    pif_wdata        : in std_logic_vector(PSIF_DATA_LENGTH-1 downto 0);
    -- Read enable strobe
    pif_re	     : in std_logic_vector(0 downto 0);
    -- Write enable strobe
    pif_we	     : in std_logic_vector(0 downto 0);
    -- Write strobes. This signal indicates which byte lanes hold
    --   valid data. There is one write strobe bit for each eight
    --   bits of the write data bus.    
    pif_be	     : in std_logic_vector((PSIF_DATA_LENGTH/8)-1 downto 0);
    -- Read data
    rdata_2pif	     : out std_logic_vector(PSIF_DATA_LENGTH-1 downto 0);
    -- Register read and write access acknowledge
    ack_2pif         : out std_logic

    -- Interrupts
  );
  end scu_reg;
