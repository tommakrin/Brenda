library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegCol is

	port ( clk : in std_logic;
			 rst : in std_logic;
			 loadEn : in std_logic;
			 col_in : in std_logic_vector (7 downto 0);
			 col_out : out std_logic_vector (127 downto 0)
			 );

end RegCol;

 architecture Behavioral of RegCol is

--Component Declaration
component reg8 is
	generic (regCount : integer := 8);
	port ( clk : in std_logic;
			 rst : in std_logic;
			 loadEn : in std_logic;
			 reg_in : in std_logic_vector (regCount-1 downto 0);
			 reg_out : out std_logic_vector (regCount-1 downto 0)
			 );
end component;

--Signal declaration
signal int: std_logic_vector(127 downto 0);

begin
		REG0: reg8 port map(clk, rst, loadEn, col_in, int(7 downto 0));
		
	registers: for i in 1 to 15 generate
		REG: reg8 port map(clk, rst, loadEn, 
								 int(i*8-1 downto i*8-8), 
								 int((i+1)*8-1 downto (i+1)*8-8)
								 );
	end generate;

col_out <= int(7 downto 0) & int(15 downto 8) & int(23 downto 16) & int(31 downto 24) 
			& int(39 downto 32) & int(47 downto 40) & int(55 downto 48) & int(63 downto 56)
			& int(71 downto 64) & int(79 downto 72) & int(87 downto 80) & int(95 downto 88) 
			& int(103 downto 96) & int(111 downto 104) & int(119 downto 112) & int(127 downto 120);

end Behavioral;

