library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library pck_lib;
use pck_lib.types.all;

entity top is
  port (
    clk : in std_logic;
    segments : out std_logic_vector(6 downto 0);
    digit_sel : out std_logic
  );
end top;

architecture str of top is

  signal rst : std_logic;
  signal value : value_type;
  signal digit_sel_i : std_logic;
  signal digits : digits_type;
  signal digit : digit_type;

begin

  digit_sel <= digit_sel_i;

  RESET : entity seg7.reset(rtl)
    port map (
      clk => clk,
      rst_in => '0',
      rst_out => rst
    );

  COUNTER : entity seg7.counter(rtl)
    port map (
      clk => clk,
      rst => rst,
      value => value
    );

  DIGIT_SELECTOR : entity seg7.digit_selector(rtl)
    port map (
      clk => clk,
      rst => rst,
      digit_sel => digit_sel_i
    );

  OUTPUT_MUX : entity seg7.output_mux(rtl)
    port map (
      digit_sel => digit_sel_i,
      digits => digits,
      digit => digit
    );

  BCD_ENCODER : entity seg7.bcd_encoder(rtl)
    port map (
      value => value,
      digits => digits
    );

  SEG7_ENCODER : entity seg7.seg7_encoder(rtl)
    port map (
      digit => digit,
      segments => segments
    );

end architecture;