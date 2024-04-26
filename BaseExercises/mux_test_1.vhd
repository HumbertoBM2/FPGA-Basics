-- Libraries
LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Entity for mux
ENTITY mux_test_1 IS 
	PORT(
		I0, I1, I2, I3			: IN std_logic;
		A, B 						: IN std_logic;
		O  						: OUT std_logic
	);
END ENTITY;

-- Architecture 
ARCHITECTURE behaviour OF mux_test_1 IS 
BEGIN 
	O <= (I0 and (not A) and (not B)) or
		  (I1 and (not A) and B) OR
		  (I2 and A and (not B)) OR
		  (I3 and A and B);
END ARCHITECTURE;