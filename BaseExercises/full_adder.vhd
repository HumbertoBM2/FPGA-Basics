-- Libraries
LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- Entity for full adder
ENTITY full_adder IS 
	PORT(
		A, B , Cin : IN std_logic;
		Cout, Sum  : OUT std_logic
	);
END ENTITY;

-- Architecture 
ARCHITECTURE behaviour OF full_adder IS 
BEGIN 
	Cout <= (A and B) or (A and Cin) or (B and Cin);
	Sum <= (A xor B) xor Cin;
END ARCHITECTURE;