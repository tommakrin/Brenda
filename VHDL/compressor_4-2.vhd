----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:48:16 04/20/2016 
-- Design Name: 
-- Module Name:    compressor_4-2 - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity compressor_4_2 is

	port(a,b,c,d,cin : in std_logic; 
		  cout, sum, carry : out std_logic
);

end compressor_4_2;

architecture Behavioral of compressor_4_2 is

-- Internal Signal Definitions
signal stage_1: std_logic;

begin

stage_1 <= d XOR (b XOR c);
cout <= NOT((b NAND c) AND (b NAND d) AND (c NAND d));
sum <= (a XOR cin) XOR stage_1;
carry <= NOT((a NAND cin) AND (stage_1 NAND cin) AND (a NAND stage_1));

end Behavioral;

