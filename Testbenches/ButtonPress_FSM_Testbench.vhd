library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ButtonPress_FSM_Testbench is end ButtonPress_FSM_Testbench;
architecture Behavior of ButtonPress_FSM_Testbench is 

  -- Component declaration ...
  component ButtonPress_FSM is
    port (
        clk, rst : in std_logic;
        b : in std_logic;
        y : out std_logic
    );
end component;

  constant CLK_PERIOD : time := 50 ns;

  signal clk_tb, rst_tb, b_tb, y_tb : std_logic;

begin
  ButtonPress_FSM_tb : ButtonPress_FSM
                       port map (clk_tb, rst_tb, b_tb, y_tb);


  -- Generate clock
  process begin
     clk_tb <= '0';
     wait for CLK_PERIOD/2;
     clk_tb <= '1';
     wait for CLK_PERIOD/2;
  end process;

  process begin
     rst_tb <= '1';
     b_tb <= '0';
     wait for CLK_PERIOD;
	  b_tb <= '1';
     rst_tb <= '0';
     wait for CLK_PERIOD;
     wait for CLK_PERIOD;
     b_tb <= '0';
	  wait for CLK_PERIOD;
     wait;
  end process;   
end Behavior;