----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Thomas Makryniotis
-- 
-- Create Date:    14:38:06 04/21/2016 
-- Design Name: 
-- Module Name:    four_12bit_word_adder - Behavioral 
-- Project Name: 
-- Target Devices: Spartan 3 Family
-- Tool versions: 
-- Description: Four 12-bit word Fast adder. Based on 4:2 compressors.
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

entity four_12bit_word_adder is

generic (
    bits: integer := 12
  );

port( --Input signals
		a_byte_in: in std_logic_vector(bits-1 downto 0);
		b_byte_in: in std_logic_vector(bits-1 downto 0);
		c_byte_in: in std_logic_vector(bits-1 downto 0);
		d_byte_in: in std_logic_vector(bits-1 downto 0);
		cin: in std_logic;
		--Output signals
		val14bit_out: out std_logic_vector(bits+1 downto 0)
);

end four_12bit_word_adder;

architecture Behavioral of four_12bit_word_adder is

-- Component Declaration

component compressor_4_2 is
	port(a,b,c,d,cin : in std_logic; 
		  cout, sum, carry : out std_logic
		  );
end component;

--------------------------------------------------------+
component generic_13bit_adder
port (
    A:  in  std_logic_vector(12 downto 0); --Input A
    B:  in  std_logic_vector(12 downto 0); --Input B
    CI: in  std_logic;							 --Carry in
    O:  out std_logic_vector(12 downto 0); --Sum
    CO: out std_logic							 --Carry Out
  );
end component;
--------------------------------------------------------+

-- Declare internal signals
signal int: std_logic_vector(bits-1 downto 0); -- int(11) is the final Cout signal
signal byte_out: std_logic_vector(bits-1 downto 0);
signal carry: std_logic_vector(bits-1 downto 0);
signal int13bit: std_logic_vector(bits downto 0);
-- The following signals are necessary to produce concatenated inputs for the 10-bit adder.
-- See the paper for more info. 
signal Concat_A: std_logic_vector(bits downto 0);
signal Concat_B: std_logic_vector(bits downto 0);
signal co : std_logic;

begin
  
	A0: compressor_4_2 port map (a_byte_in(0), b_byte_in(0), 
                                c_byte_in(0), d_byte_in(0),
                                '0', int(0), byte_out(0), carry(0));
	instances: for i in 1 to bits-1 generate
		A: compressor_4_2 port map (a_byte_in(i), b_byte_in(i), 
											 c_byte_in(i), d_byte_in(i), int(i-1),
											 int(i), byte_out(i), carry(i));
	end generate;

	G13: generic_13bit_adder port map (Concat_A, Concat_B, '0', int13bit, co);
	
Concat_A <= int(11) & byte_out;
Concat_B <= carry & '0';

val14bit_out <= '1' & int13bit when (co= '1') else
                '0' & int13bit;

end Behavioral;