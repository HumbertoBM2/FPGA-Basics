-- AD_FSM_Testbench.vhd
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY AD_FSM_Testbench IS
END ENTITY;

ARCHITECTURE behaviour OF AD_FSM_Testbench IS
	COMPONENT AD_FSM IS
		PORT (clk, rst : IN STD_LOGIC;
				g, h : IN STD_LOGIC;
				x, y : OUT STD_LOGIC);
	END COMPONENT;
	
	CONSTANT CLK_PERIOD : time := 50 ns;
	SIGNAL clk_tb, rst_tb, g_tb, h_tb, x_tb, y_tb : STD_LOGIC;
	
	BEGIN 
		AD_FSM_tb : AD_FSM
			PORT MAP (clk_tb, rst_tb, g_tb, h_tb, x_tb, y_tb);
		-- Generate clock
		PROCESS BEGIN
			clk_tb <= '0';
			WAIT FOR CLK_PERIOD/2;
			clk_tb <= '1';
			WAIT FOR CLK_PERIOD/2;
		END PROCESS;
		
		PROCESS BEGIN
			rst_tb <= '1';
			g_tb <= '0';
			h_tb <= '0';
			WAIT FOR CLK_PERIOD;
			g_tb <= '1';
			rst_tb <= '0';
			WAIT FOR CLK_PERIOD;
			g_tb <= '0';
			h_tb <= '1';
			WAIT FOR CLK_PERIOD;
			g_tb <= '1';
			WAIT FOR CLK_PERIOD;
			g_tb <= '0';
			WAIT FOR CLK_PERIOD;
			h_tb <= '0';
			WAIT FOR CLK_PERIOD;
			WAIT;
		END PROCESS;
END ARCHITECTURE;
			
				
	