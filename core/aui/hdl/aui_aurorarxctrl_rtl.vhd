
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library psif_lib;
use psif_lib.psif_pck.all;

architecture rtl of aui_aurorarxctrl is

  type t_aurora_rx_fsm_state is (IDLE, FIFO_LOOP_RD_WAIT, FIFO_LOOP_WR);
  signal aurora_rx_fsm_state : t_aurora_rx_fsm_state;  

  -- Internal signals
  -- TBD
   
begin

  P_AURORA_LOOP_AND_RX_CTRL_FSM:
  process (rst, mclk) is
  begin
    if ( rst = '1') then

      ps_txfifo_data_rd   <= '0';
      ps_rxfifo_wr        <= '0';
      rx_data             <= (others => '0');
      aurora_rx_fsm_state <= IDLE;

    elsif rising_edge(mclk) then

      -- Default values
      ps_txfifo_data_rd   <= '0';
      ps_rxfifo_wr        <= '0';
      rx_data             <= (others => '0');
 
      case aurora_rx_fsm_state is

        when IDLE  =>
          -- If looping is enbled will data be read from the TX FIFO when
          -- data output from TX FIFO is enbled and the FIFO is not empty 
          if (access_loop_ena='1' and fifo_tx_write_enable='1' and unsigned(ps_txfifo_count) > 0) then
            ps_txfifo_data_rd <= '1';
            aurora_rx_fsm_state  <= FIFO_LOOP_RD_WAIT;
            
          -- elsif "Write AXI4Stream RX data to RX FIFO when aksess loop is disabled
          --        (i.e. '0') and tvalid is active (i.e. '1')"
          elsif (access_loop_ena='0' and m_axi_rx_tvalid = '1') then
             --aurora_rx_fsm_state  <= FIFO_AURORA_WAIT;
            ps_rxfifo_wr <= '1';
            rx_data <= m_axi_rx_tdata;

            -- ADD YOUR CODE !!
            
          end if;



        when FIFO_LOOP_RD_WAIT =>    
         aurora_rx_fsm_state  <= FIFO_LOOP_WR;      
                            
        when FIFO_LOOP_WR =>
          ps_rxfifo_wr <= '1';
          rx_data      <= ps_txfifo_data;  
          aurora_rx_fsm_state <= IDLE;      
          
      end case;
      
    end if;
    
  end process P_AURORA_LOOP_AND_RX_CTRL_FSM;
  
  
end rtl;
