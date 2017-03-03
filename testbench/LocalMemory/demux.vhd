----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:41:47 04/12/2016 
-- Design Name: 
-- Module Name:    LocalMemory_Demux - Behavioral 
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

entity LocalMemory_Demux is
	port (
      cb0_o : out std_logic_vector(127 downto 0);
      rb1_o : out std_logic_vector(127 downto 0);
      rb2_o : out std_logic_vector(127 downto 0);
      rb3_o : out std_logic_vector(127 downto 0);
      sel_i : in std_logic_vector(1 downto 0);
      data_i : in std_logic_vector(127 downto 0));
end LocalMemory_Demux;

architecture Behavioral of LocalMemory_Demux is

begin
	process(data_i,sel_i)
		begin
			case sel_i is
				when "00" => cb0_o <= data_i; rb1_o <= (others => '0'); rb2_o <= (others => '0'); rb3_o <=(others => '0');
				when "01" => rb1_o <= data_i; cb0_o <= (others => '0'); rb2_o <= (others => '0'); rb3_o <=(others => '0');
				when "10" => rb2_o <= data_i; cb0_o <= (others => '0'); rb1_o <= (others => '0'); rb3_o <=(others => '0');
				when "11" => rb3_o <= data_i; cb0_o <= (others => '0'); rb1_o <= (others => '0'); rb2_o <=(others => '0');
				when others => cb0_o <= (others => '0'); rb1_o <= (others => '0'); rb2_o <= (others => '0'); rb3_o <=(others => '0');
			end case; 
	end process;
end Behavioral;

