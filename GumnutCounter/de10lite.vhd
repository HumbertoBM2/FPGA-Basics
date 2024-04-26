library ieee;
use ieee.std_logic_1164.all, ieee.numeric_std.all;

entity de10lite is
port (
    CLOCK_50 : in std_logic;
    KEY : in std_logic_vector( 1 downto 0 );
    SW : in std_logic_vector( 9 downto 0 );
    LEDR : out std_logic_vector( 9 downto 0 );
    HEX0_msb: out std_logic_vector(7 downto 0)
);
end de10lite;

architecture Structural of de10lite is

component gumnut_with_mem is
generic (
    IMem_file_name : string := "gasm_text.dat";
    DMem_file_name : string := "gasm_data.dat";
    debug : boolean := false
);
port (
    clk_i : in std_logic;
    rst_i : in std_logic;
    -- I/O port bus
    port_cyc_o : out std_logic;
    port_stb_o : out std_logic;
    port_we_o : out std_logic;
    port_ack_i : in std_logic;
    port_adr_o : out unsigned(7 downto 0);
    port_dat_o : out std_logic_vector(7 downto 0);
    port_dat_i : in std_logic_vector(7 downto 0);
    -- Interrupts
    int_req : in std_logic;
    int_ack : out std_logic
);
end component gumnut_with_mem;

component bcd7seg is
port (
    bcd : in std_logic_vector(3 downto 0);
    display : out std_logic_vector(7 downto 0)
);
end component bcd7seg;

signal clk_i, rst_i: std_logic;
signal port_cyc_o, port_stb_o, port_we_o, port_ack_i: std_logic;
signal port_adr_o: unsigned(7 downto 0);
signal port_dat_o, port_dat_i: std_logic_vector(7 downto 0);
signal int_req, int_ack: std_logic;
signal bcd_msb_i: std_logic_vector(3 downto 0);


begin

clk_i <= CLOCK_50;
rst_i <= not KEY( 0 );
port_ack_i <= '1';

gumnut : component gumnut_with_mem
port map (
    clk_i,
    rst_i,
    port_cyc_o,
    port_stb_o,
    port_we_o,
    port_ack_i,
    port_adr_o( 7 downto 0 ),
    port_dat_o( 7 downto 0 ),
    port_dat_i( 7 downto 0 ),
    int_req,
    int_ack
);

msb: component bcd7seg
port map ( bcd_msb_i, HEX0_msb );



-- Output => LEDR => HEX
process( clk_i )
begin
    if rising_edge( clk_i ) then
        if port_cyc_o = '1' and port_stb_o = '1' and port_we_o = '1' then

            bcd_msb_i <= port_dat_o( 3 downto 0 );
            LEDR( 7 downto 0 ) <= port_dat_o( 7 downto 0 );
		
	elsif port_cyc_o = '1' and port_stb_o = '1' and port_we_o = '0' then
	    
	    if port_adr_o(1) = '0' and port_adr_o(0) = '0' then

		if KEY( 1 ) = '1' then
		    port_dat_i <= std_logic_vector( to_unsigned( 1, 8) );
		elsif KEY(1) = '0' then
		    port_dat_i <= std_logic_vector( to_unsigned( 0, 8) );
		end if;

	    elsif port_adr_o(1) = '0' and port_adr_o(0) = '1' then
			
		port_dat_i( 3 downto 0 ) <= SW( 3 downto 0 );

	    end if;

	end if;
    end if;
end process;

LEDR(9 downto 8) <= ( others => '0' );

end Structural;
