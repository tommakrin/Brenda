----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:48:06 04/24/2016 
-- Design Name: 
-- Module Name:    generic_9bit_adder - Behavioral 
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
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity generic_9bit_adder is
  generic (
    bits: integer := 9
  );
  port (
    A:  in  std_logic_vector(bits-1 downto 0);
    B:  in  std_logic_vector(bits-1 downto 0);
    CI: in  std_logic;
    O:  out std_logic_vector(bits-1 downto 0);
    CO: out std_logic
  );
end entity generic_9bit_adder;

architecture Behavioral of generic_9bit_adder is
begin

process(A,B,CI)

  variable sum:         integer;
  
  -- Note: we have one bit more to store carry out value.
  variable sum_vector:  std_logic_vector(bits downto 0); 

begin

  -- Compute our integral sum, by converting all operands into integers.

  sum := conv_integer(A) + conv_integer(B) + conv_integer(CI);

  -- Now, convert back the integral sum into a std_logic_vector, of size bits+1

  sum_vector := conv_std_logic_vector(sum, bits+1);

  -- Assign outputs
  O <= sum_vector(bits-1 downto 0);

  CO <=  sum_vector(bits); -- Carry is the most significant bit

end process;

end Behavioral;