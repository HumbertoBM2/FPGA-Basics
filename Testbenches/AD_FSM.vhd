-- AD_FSM.vhd
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY AD_FSM IS
	PORT (clk, rst : IN STD_LOGIC;
			g, h : IN STD_LOGIC;
			x, y : OUT STD_LOGIC);
END ENTITY;


ARCHITECTURE behaviour OF AD_FSM IS
BEGIN
	PROCESS(clk)
		type AD_statetype IS (AD_Wait, AD_Preheat, AD_Dispense);
		variable AD_State : AD_statetype;
	BEGIN
		IF (rising_edge(clk)) THEN 
			IF(rst = '1') THEN 
				AD_State := AD_Wait;
			ELSE
			-- STATE TRANSITIONS
				CASE AD_State IS
					WHEN AD_Wait => 
						IF((not g) = '1') THEN 
							AD_State := AD_Wait;
						ELSIF (g = '1') THEN
							AD_State := AD_Preheat;
						END IF;
					WHEN AD_Preheat => 
						AD_State := AD_Dispense;
					WHEN AD_Dispense => 
						IF((not h) = '1') THEN 
							AD_State := AD_Wait;
						ELSIF (h = '1') THEN
							AD_State := AD_Dispense;
						END IF;
					WHEN OTHERS =>
						AD_State := AD_Wait;
				END CASE;
			END IF;
			-- STATE ACTIONS
			CASE AD_State IS 
				WHEN AD_Wait =>
					x <= '0';
					y <= '0';
				WHEN AD_Preheat =>
					y <= '0';
					x <= '1';
				WHEN AD_Dispense =>
					y <= '1';
					x <= '0';
				WHEN OTHERS =>
					y <= '0';
					x <= '0';
			END CASE;
		END IF;
	END PROCESS;
END ARCHITECTURE;
				