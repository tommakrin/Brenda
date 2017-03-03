library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.all;

entity mux16x1 is
	generic
	(
		N	: integer  :=	128;
		inputs: integer := 16
	);
	port
	(
		-- Input ports
		sel		: in std_logic_vector(3 DOWNTO 0);
		data_in	: in  std_logic_vector(N*inputs-1 DOWNTO 0);

		-- Output ports
		data_out : out std_logic_vector(N-1 DOWNTO 0)
	);
end mux16x1;

architecture behaviour of mux16x1 is
begin
	selection:
		with sel select
		data_out <= 
					data_in(127 downto 0) 		  when "1111",
					data_in(255 downto 128) 	 when "1110",
					data_in(383 downto 256) 	 when "1101",
					data_in(511 downto 384) 	 when "1100",
					data_in(639 downto 512) 	 when "1011",
					data_in(767 downto 640) 	 when "1010",
					data_in(895 downto 768) 	 when "1001",
					data_in(1023 downto 896) 	when "1000",
					data_in(1151 downto 1024) when "0111",
					data_in(1279 downto 1152)	when "0110",
					data_in(1407 downto 1280) when "0101",
					data_in(1535 downto 1408) when "0100",
					data_in(1663 downto 1536) when "0011",
					data_in(1791 downto 1664)	when "0010",
					data_in(1919 downto 1792)	when "0001",
					data_in(2047 downto 1920) when "0000",
				  (others => '0')           when others;	
end behaviour;