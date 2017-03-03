library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.all;

entity mux3x1 is
	generic
	(
		N	: integer  :=	128
	);
	port
	(
		-- Input ports
		sel		: in std_logic_vector(1 DOWNTO 0);
		data_a	: in  std_logic_vector(N-1 DOWNTO 0);
		data_b	: in  std_logic_vector(N-1 DOWNTO 0);
		data_c	: in  std_logic_vector(N-1 DOWNTO 0);
		-- Output ports
		data_out : out std_logic_vector(N-1 DOWNTO 0)
	);
end mux3x1;

architecture behaviour of mux3x1 is
begin
	selection:
		with sel select
		data_out <= 
					data_a when "00",
					data_b when "01",
					data_c when "10",
					(others => '0') when others;	
end behaviour;

