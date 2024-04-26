-- Library declaration
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- NAND Entity
ENTITY nand_gate IS
	PORT(
	a, b : IN std_logic;
	y    : OUT std_logic);
END ENTITY;

-- NAND Architecture 
ARCHITECTURE behavioural OF nand_gate IS
BEGIN
	y <= a NAND b;
END ARCHITECTURE;