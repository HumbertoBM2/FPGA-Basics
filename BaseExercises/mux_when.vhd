-- Libraries
LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Entity for mux
ENTITY mux_when IS 
	PORT(
		I0, I1, I2, I3			: IN std_logic;
		sel 						: IN std_logic_vector(1 DOWNTO 0);
		O  						: OUT std_logic
	);
END ENTITY;

-- Architecture 
ARCHITECTURE behaviour OF mux_when IS 
BEGIN 
	O <= I0 WHEN sel = "00" ELsE
		  I1 WHEN sel = "01" ELSE
		  I2 WHEN sel = "10" ELSE 
		  I3;
END ARCHITECTURE;