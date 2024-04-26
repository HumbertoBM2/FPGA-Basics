-- Libraries
LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Entity for mux
ENTITY mux_select IS 
	PORT(
		I0, I1, I2, I3			: IN std_logic;
		sel 						: IN std_logic_vector(1 DOWNTO 0);
		O  						: OUT std_logic
	);
END ENTITY;

-- Architecture 
ARCHITECTURE behaviour OF mux_select IS 
BEGIN 
	WITH sel SELECT 
	O <= I0 WHEN "00",
		  I1 WHEN "01",
		  I2 WHEN "10",
		  I3 WHEN OTHERS;
END ARCHITECTURE;