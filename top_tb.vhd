library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library pck_lib;
use pck_lib.sim.all;

library seg7_lib;

entity top_tb is
end top_tb; 

architecture sim of top_tb is

  signal clk : std_logic := '1';
  signal segments : std_logic_vector(6 downto 0);
  signal digit_sel : std_logic;

begin

  clk <= not clk after sim_clk_period / 2;

  DUT : entity seg7_lib.top(str)
    port map (
      clk => clk,
      segments => segments,
      digit_sel => digit_sel
    );

  SEQUENCER_PROC : process
  begin
    wait for 100 * sim_clk_period;

    report "Checking reset values";
    
    assert segments = "0111111"
      report "segments output not reset to b0111111"
      severity failure;
    
    assert digit_sel = '0'
      report "digit_sel output not reset to 0"
      severity failure;

    print_ok_and_finish;
  end process;

end architecture;