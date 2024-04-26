LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY vga IS
	GENERIC (
		Ha: INTEGER := 96; --Hpulse
		Hb: INTEGER := 144; --Hpulse+HBP
		Hc: INTEGER := 784; --Hpulse+HBP+Hactive
		Hd: INTEGER := 800; --Hpulse+HBP+Hactive+HFP
		Va: INTEGER := 2; --Vpulse
		Vb: INTEGER := 35; --Vpulse+VBP
		Vc: INTEGER := 515; --Vpulse+VBP+Vactive
		Vd: INTEGER := 525); --Vpulse+VBP+Vactive+VFP
	PORT (
		clk: IN STD_LOGIC; --50MHz in our board
		red_switch, green_switch, blue_switch: IN STD_LOGIC;
		pixel_clk: BUFFER STD_LOGIC;
		Hsync, Vsync: BUFFER STD_LOGIC;
		R, G, B: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		nblanck, nsync : OUT STD_LOGIC);
	END vga;

ARCHITECTURE vga OF vga IS
SIGNAL Hactive, Vactive, dena: STD_LOGIC;
BEGIN
-------------------------------------------------------
--Part 1: CONTROL GENERATOR
-------------------------------------------------------
	--Static signals for DACs:
	nblanck <= '1'; --no direct blanking
	nsync <= '0'; --no sync on green
	--Create pixel clock (50MHz->25MHz):
	PROCESS (clk)
	BEGIN
		IF (clk'EVENT AND clk='1') THEN pixel_clk <= NOT pixel_clk;
		END IF;
	END PROCESS;
	--Horizontal signals generation:
	PROCESS (pixel_clk)
	VARIABLE Hcount: INTEGER RANGE 0 TO Hd;
	BEGIN
		IF (pixel_clk'EVENT AND pixel_clk='1') THEN Hcount := Hcount + 1;
			IF (Hcount=Ha) THEN Hsync <= '1';
			ELSIF (Hcount=Hb) THEN Hactive <= '1';
			ELSIF (Hcount=Hc) THEN Hactive <= '0';
			ELSIF (Hcount=Hd) THEN Hsync <= '0'; Hcount := 0;
			END IF;
		END IF;
	END PROCESS;
	--Vertical signals generation:
	PROCESS (Hsync)
	VARIABLE Vcount: INTEGER RANGE 0 TO Vd;
	BEGIN
		IF (Hsync'EVENT AND Hsync='0') THEN Vcount := Vcount + 1;
			IF (Vcount=Va) THEN Vsync <= '1';
			ELSIF (Vcount=Vb) THEN Vactive <= '1';
			ELSIF (Vcount=Vc) THEN Vactive <= '0';
			ELSIF (Vcount=Vd) THEN Vsync <= '0'; Vcount := 0;
			END IF;
		END IF;
	END PROCESS;
	---Display enable generation:
	dena <= Hactive AND Vactive;
	-------------------------------------------------------
	--Part 2: IMAGE GENERATOR
	-------------------------------------------------------
	PROCESS (Hsync, Vsync, Vactive, dena, red_switch, green_switch, blue_switch)
    VARIABLE line_counter: INTEGER RANGE 0 TO Vc;
	 VARIABLE column_counter: INTEGER RANGE 0 TO HC;
BEGIN
    IF (Vsync = '0') THEN
        line_counter := 0;
    ELSIF (Hsync'EVENT AND Hsync = '1') THEN
        IF (Vactive = '1') THEN
            line_counter := line_counter + 1;
        END IF;
    END IF;
    IF (dena = '1') THEN
    IF (line_counter <= 60) THEN
        IF (column_counter <= 80) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '0');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 160 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 240 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '0');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 320 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '0');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 400 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '0');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 480 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '0');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 560 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 680 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '0');
            B <= (OTHERS => '0');
        END IF;
    ELSIF (line_counter <= 120) THEN
        IF (column_counter <= 80) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '0');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 160 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 240 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 320 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 400 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 480 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 560 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 680 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '0');
            B <= (OTHERS => '0');
	END IF;
    ELSIF (line_counter <= 180) THEN
        IF (column_counter <= 80) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '0');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 160 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 240 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 320 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 400 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 480 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 560 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 680 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '0');
            B <= (OTHERS => '0');
	END IF;
    ELSIF (line_counter <= 240) THEN
        IF (column_counter <= 80) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '0');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 160 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 240 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '0');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 320 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 400 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 480 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '0');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 560 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 680 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '0');
            B <= (OTHERS => '0');
	END IF;
    ELSIF (line_counter <= 300) THEN
        IF (column_counter <= 80) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '0');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 160 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 240 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 320 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 400 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 480 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 560 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 680 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '0');
            B <= (OTHERS => '0');
	END IF;
    ELSIF (line_counter <= 360) THEN
        IF (column_counter <= 80) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '0');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 160 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 240 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 320 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '0');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 400 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '0');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 480 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 560 ) THEN
            R <= (OTHERS => '1');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 680 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '0');
            B <= (OTHERS => '0');
	END IF;
    ELSIF (line_counter <= 420) THEN
        IF (column_counter <= 80) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '1');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 160 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 240 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 320 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 400 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 480 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 560 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 680 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '1');
            B <= (OTHERS => '0');
	END IF;
    ELSIF (line_counter <= 480) THEN
        IF (column_counter <= 80) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '1');
            B <= (OTHERS => '0');
    	ELSIF ( column_counter <= 160 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 240 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 320 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 400 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 480 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 560 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '1');
            B <= (OTHERS => '1');
    	ELSIF ( column_counter <= 680 ) THEN
            R <= (OTHERS => '0');
            G <= (OTHERS => '1');
            B <= (OTHERS => '0');
	END IF;
    ELSE
        R <= (OTHERS => '0');
        G <= (OTHERS => '0');
        B <= (OTHERS => '0');
    END IF;
ELSE
    -- In the blanking area, set to black
    R <= (OTHERS => '0');
    G <= (OTHERS => '0');
    B <= (OTHERS => '0');
END IF;

	 
	 IF(Hsync = '0') THEN
		column_counter := 0;
	 ELSIF (pixel_clk' EVENT AND pixel_clk='1') THEN
		IF(Hactive='1') THEN
			column_counter := column_counter + 1;
		END IF;
	 END IF;
	 
END PROCESS;

END vga;