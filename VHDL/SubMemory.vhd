library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SubMemory is

	port ( clk : in std_logic;
			   rst : in std_logic;
			   loadEn : in std_logic;
			   colsel: in std_logic_vector(3 downto 0);
			   array_in : in std_logic_vector (127 downto 0);
			   array_out : out std_logic_vector (127 downto 0)
			 );

end SubMemory;

architecture Behavioral of SubMemory is

--Component Declaration

component RegCol is
	port ( clk : in std_logic;
			 rst : in std_logic;
			 loadEn : in std_logic;
			 col_in : in std_logic_vector (7 downto 0);
			 col_out : out std_logic_vector (127 downto 0)
			 );
end component;

component mux16x1 is
	port
	(	sel		: in std_logic_vector(3 downto 0);
		data_in	: in  std_logic_vector(2047 downto 0);
		data_out : out std_logic_vector(127 downto 0)
	);
end component;

--Declare internal signals
signal cols_out_int: std_logic_vector(2047 downto 0);

begin

	instances: for i in 1 to 16 generate
		Cols: RegCol port map (clk, rst, loadEn, 
									  array_in(i*8-1 downto i*8-8),
									  cols_out_int(i*128-1 downto i*128-128));
	end generate;
	
	Mux: mux16x1 port map (colsel, cols_out_int, array_out); 
end Behavioral;

