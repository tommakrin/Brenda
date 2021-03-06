library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.std_logic_arith.ALL;
use IEEE.std_logic_unsigned.ALL;

entity reg8 is
	generic (regCount : integer := 8);
	port ( clk : in std_logic;
			 rst : in std_logic;
			 loadEn : in std_logic;
			 reg_in : in std_logic_vector (regCount-1 downto 0);
			 reg_out : out std_logic_vector (regCount-1 downto 0)
			 );
end reg8 ;

architecture Behavioral of reg8 is

begin 
	process (clk, rst)
		begin
		if rst = '1' then
			reg_out <= (others => '0'); 
		elsif rising_edge(clk) then
			if loadEn = '1' then
				reg_out <= reg_in;
			end if;
		end if;
	end process;
	
end Behavioral;
