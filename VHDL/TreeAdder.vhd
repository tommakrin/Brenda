----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:19:43 04/25/2016 
-- Design Name: 
-- Module Name:    TreeAdder - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TreeAdder is
    port ( AD_DATA : in  STD_LOGIC_VECTOR (2047 downto 0);
           SAD : out  STD_LOGIC_VECTOR (15 downto 0));
end TreeAdder;

architecture Behavioral of TreeAdder is

-- Declare components

component x16_byte_adder is
	port ( data_i : in std_logic_vector(127 downto 0);
		    sum_12bit_o : out std_logic_vector(11 downto 0)
		    );
end component;

component four_12bit_word_adder
	port(	a_byte_in: in std_logic_vector(11 downto 0);
			b_byte_in: in std_logic_vector(11 downto 0);
			c_byte_in: in std_logic_vector(11 downto 0);
			d_byte_in: in std_logic_vector(11 downto 0);
			cin: in std_logic;
			val14bit_out: out std_logic_vector(13 downto 0)
	);
end component;

component four_14bit_word_adder
	port(	a_byte_in: in std_logic_vector(13 downto 0);
			b_byte_in: in std_logic_vector(13 downto 0);
			c_byte_in: in std_logic_vector(13 downto 0);
			d_byte_in: in std_logic_vector(13 downto 0);
			cin: in std_logic;
			val16bit_out: out std_logic_vector(15 downto 0)
	);
end component;

--Declare signals
signal bus192: std_logic_vector(191 downto 0);
signal bus56: std_logic_vector(55 downto 0);

begin

	x16inst: for i in 16 downto 1 generate
		X16: x16_byte_adder port map (AD_DATA(128*i-1 downto 128*i-128), 
		                              bus192(12*i-1 downto 12*i-12));
	end generate;
	
	f12inst: for k in 4 downto 1 generate
		F12: four_12bit_word_adder port map (bus192(48*k-1 downto 48*k-12),
													    bus192(48*k-13 downto 48*k-2*12),
  													    bus192(48*k-2*12-1 downto 48*k-3*12),
													    bus192(48*k-3*12-1 downto 48*k-4*12),
													    '0', bus56(14*k-1 downto 14*k-14));
	end generate;
	
	F14: four_14bit_word_adder port map (bus56(55 downto 42),
													 bus56(41 downto 28),
													 bus56(27 downto 14),
													 bus56(13 downto 0),
													 '0', SAD);

end Behavioral;

