----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:49:30 04/20/2016 
-- Design Name: 
-- Module Name:    PE_ARRAY_16X16 - Behavioral 
-- Project Name: 
-- Target Devices: Spartan 3 family.
-- Tool versions: 
-- Description: The PE Array, responsible for the parallel calculation of Absolute differences.
--
-- Dependencies: pe_16x1.vhd
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

entity PE_ARRAY_16X16 is
  port(
    --Output signals
    CAD_o : out std_logic_vector(2047 downto 0);
    
    --Input signals
    --Control Signals
    cb_en_i : in std_logic;
    rb_en_i : in std_logic;
    diff_en_i: in std_logic;
    clk_i : in std_logic;
    rst_i : in std_logic;
    
    --Data Signals
    CB_i : in std_logic_vector(127 downto 0);
    RB_i : in std_logic_vector(127 downto 0)
  );
end PE_ARRAY_16X16;

architecture Behavioral of PE_ARRAY_16X16 is

--------Define Components-----------

component pe_16x1 is
  port (
	 --Output signals
    CAD0_o : out std_logic_vector(127 downto 0);
    
    --Input signals
    --Control Signals
    cb_en_i : in std_logic;
    rb_en_i : in std_logic;
    diff_en_i: in std_logic;
    clk_i : in std_logic;
    rst_i : in std_logic;
    
    --Data Signals
    CB_i : in std_logic_vector(7 downto 0);
    RB_i : in std_logic_vector(7 downto 0)
	 );
end component;

----- Define Internal Signals -----
signal pe_cad: std_logic_vector(2047 downto 0); --Concatenated Absolute Diff

----- Begin architecture description

begin
  R0: pe_16x1 port map ( pe_cad(127 downto 0), 
								cb_en_i, rb_en_i, 
								diff_en_i, clk_i, rst_i,
								CB_i(7 downto 0), RB_i(7 downto 0));
								
  R1: pe_16x1 port map ( pe_cad(255 downto 128), 
								cb_en_i, rb_en_i, 
								diff_en_i, clk_i, rst_i,
								CB_i(15 downto 8), RB_i(15 downto 8));
								
  R2: pe_16x1 port map ( pe_cad(383 downto 256), 
								cb_en_i, rb_en_i, 
								diff_en_i, clk_i, rst_i,
								CB_i(23 downto 16), RB_i(23 downto 16));
								
  R3: pe_16x1 port map ( pe_cad(511 downto 384), 
								cb_en_i, rb_en_i, 
								diff_en_i, clk_i, rst_i,
								CB_i(31 downto 24), RB_i(31 downto 24));
								
  R4: pe_16x1 port map ( pe_cad(639 downto 512), 
								cb_en_i, rb_en_i, 
								diff_en_i, clk_i, rst_i,
								CB_i(39 downto 32), RB_i(39 downto 32));
								
  R5: pe_16x1 port map ( pe_cad(767 downto 640), 
								cb_en_i, rb_en_i, 
								diff_en_i, clk_i, rst_i,
								CB_i(47 downto 40), RB_i(47 downto 40));
								
  R6: pe_16x1 port map ( pe_cad(895 downto 768), 
								cb_en_i, rb_en_i, 
								diff_en_i, clk_i, rst_i,
								CB_i(55 downto 48), RB_i(55 downto 48));
								
  R7: pe_16x1 port map ( pe_cad(1023 downto 896), 
								cb_en_i, rb_en_i, 
								diff_en_i, clk_i, rst_i,
								CB_i(63 downto 56), RB_i(63 downto 56));
								
  R8: pe_16x1 port map ( pe_cad(1151 downto 1024), 
								cb_en_i, rb_en_i, 
								diff_en_i, clk_i, rst_i,
								CB_i(71 downto 64), RB_i(71 downto 64));
								
  R9: pe_16x1 port map ( pe_cad(1279 downto 1152), 
								cb_en_i, rb_en_i, 
								diff_en_i, clk_i, rst_i,
								CB_i(79 downto 72), RB_i(79 downto 72));
								
  R10: pe_16x1 port map ( pe_cad(1407 downto 1280), 
								cb_en_i, rb_en_i, 
								diff_en_i, clk_i, rst_i,
								CB_i(87 downto 80), RB_i(87 downto 80));
								
  R11: pe_16x1 port map ( pe_cad(1535 downto 1408), 
								cb_en_i, rb_en_i, 
								diff_en_i, clk_i, rst_i,
								CB_i(95 downto 88), RB_i(95 downto 88));
								
  R12: pe_16x1 port map ( pe_cad(1663 downto 1536), 
								cb_en_i, rb_en_i, 
								diff_en_i, clk_i, rst_i,
								CB_i(103 downto 96), RB_i(103 downto 96));
								
  R13: pe_16x1 port map ( pe_cad(1791 downto 1664), 
								cb_en_i, rb_en_i, 
								diff_en_i, clk_i, rst_i,
								CB_i(111 downto 104), RB_i(111 downto 104));
								
  R14: pe_16x1 port map ( pe_cad(1919 downto 1792), 
								cb_en_i, rb_en_i, 
								diff_en_i, clk_i, rst_i,
								CB_i(119 downto 112), RB_i(119 downto 112));
								
  R15: pe_16x1 port map ( pe_cad(2047 downto 1920), 
								cb_en_i, rb_en_i, 
								diff_en_i, clk_i, rst_i,
								CB_i(127 downto 120), RB_i(127 downto 120));										
								
CAD_o <= pe_cad;

end Behavioral;