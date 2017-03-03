----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:36:18 04/27/2016 
-- Design Name: 
-- Module Name:    X16Comparator - Behavioral 
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity X16Comparator is

port (  
	  sad_cur, sad	: in std_logic_vector(15 downto 0);
	  pos_cur, pos	: in std_logic_vector(10 downto 0);
	  minSAD			: out std_logic_vector(15 downto 0);
	  minPOS			: out std_logic_vector(10 downto 0);
	  clk, rst : in std_logic
   );

end X16Comparator;

architecture Behavioral of X16Comparator is

signal aeqb, altb, agtb: std_logic;

begin

	aeqb <= '1' when (sad_cur = sad) else '0';
	altb <= '1' when (sad_cur < sad) else '0';
	agtb <= '1' when (sad_cur > sad) else '0';

	process(aeqb, altb, agtb, clk, rst)
	begin
	  if (rst = '1' AND rising_edge(clk)) then
	    minSAD <= (others => '1');
	    minPOS <= (others => '1');
	  end if;
	  
    		if (aeqb = '1' or agtb = '1') then
			   minSAD <= sad;
			   minPOS <= pos;
		    elsif (altb = '1') then
			 	 minSAD <= sad_cur;
			    minPOS <= pos_cur;
		    end if;
		    
	end process;

end Behavioral;
