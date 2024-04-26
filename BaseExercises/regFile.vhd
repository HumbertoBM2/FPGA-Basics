-- Librerias
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

-- Entidad del RegFile
ENTITY regFile IS
    GENERIC (
        Dwidth : INTEGER := 8; -- Data width
        Awidth : INTEGER := 2 -- Addesss width
    );
    PORT (
        clk, wren   : IN STD_LOGIC; -- Clock y write enable
        wdata       : IN STD_LOGIC_VECTOR(Dwidth-1 DOWNTO 0); -- Input
        waddr, raddr: IN STD_LOGIC_VECTOR(Awidth-1 DOWNTO 0); -- Direccion de lectura y escritura
        rdata       : OUT STD_LOGIC_VECTOR(Dwidth-1 DOWNTO 0) -- Output
    );
END ENTITY regFile;

-- Arquitectura del RegFile
ARCHITECTURE RFile_Arch OF regFile IS
    TYPE array_type IS ARRAY (0 TO 2**Awidth-1) OF STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0); -- Arreglo para el regFile
    SIGNAL array_reg : array_type; -- Señal para el regFile
BEGIN 
    rf_proc : PROCESS(clk, wren, wdata, waddr, raddr)
    BEGIN
        
            IF wren = '1' THEN -- Escribir datos en la direccion especificada si la escritura esta habilitada
                array_reg(to_integer(unsigned(waddr))) <= wdata;
            END IF;
            rdata <= array_reg(to_integer(unsigned(raddr))); -- Lectura de los datos de la direccion y output
        
    END PROCESS rf_proc;
END ARCHITECTURE RFile_Arch;
