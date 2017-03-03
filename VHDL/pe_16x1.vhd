----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:29:09 04/20/2016 
-- Design Name: 
-- Module Name:    pe_16x1 - Behavioral 
-- Project Name: 
-- Target Devices: Spartan 3 Series
-- Tool versions: 
-- Description: 16x1 Processing Array. Full Row.
--
-- Dependencies: pe_element.vhd
--					  pe_8x1.vhd
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pe_16x1 is
  port(
    --Output signals
    CAD0_o : out std_logic_vector(127 downto 0);
	 
	 --Shift output signals. Use them if you want to extend the design.
	 --Otherwise, you can safely comment them out.
	 --SHIFT_CB_o : out std_logic_vector(7 downto 0);
	 --SHIFT_RB_o : out std_logic_vector(7 downto 0);
    
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
end pe_16x1;

architecture Behavioral of pe_16x1 is

--------Define Components-----------

component pe_8x1 is
  port (
 --Output signals
    AD0_o : out std_logic_vector(7 downto 0);
    AD1_o : out std_logic_vector(7 downto 0);
	 AD2_o : out std_logic_vector(7 downto 0);
    AD3_o : out std_logic_vector(7 downto 0);
	 AD4_o : out std_logic_vector(7 downto 0);
    AD5_o : out std_logic_vector(7 downto 0);
	 AD6_o : out std_logic_vector(7 downto 0);
    AD7_o : out std_logic_vector(7 downto 0);
	 
	 --Shift output signals. Use them if you want to extend the design.
	 --Otherwise, you can safely comment them out.
	 SHIFT_CB_o : out std_logic_vector(7 downto 0);
	 SHIFT_RB_o : out std_logic_vector(7 downto 0);
    
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

-----Component Definitions End ----

----- Define Internal Signals -----
signal pe_cad: std_logic_vector(127 downto 0); --Concatenated Absolute Diff

--Intermediate signals. For 8 PEs we need 7 intermediate signals.
signal shift_cb_0: std_logic_vector(7 downto 0);
signal shift_rb_0: std_logic_vector(7 downto 0);

----- Internal Signal Definitions End -----

begin
  RP0: pe_8x1 port map ( pe_cad(7 downto 0), 
								pe_cad(15 downto 8), 
								pe_cad(23 downto 16), 
								pe_cad(31 downto 24), 
								pe_cad(39 downto 32), 
								pe_cad(47 downto 40), 
								pe_cad(55 downto 48), 
								pe_cad(63 downto 56),
								shift_cb_0, shift_rb_0,
								cb_en_i, rb_en_i, 
								diff_en_i, clk_i, rst_i,
								CB_i, RB_i);
									
  RP1: pe_8x1 port map ( pe_cad(71 downto 64), 
								pe_cad(79 downto 72), 
								pe_cad(87 downto 80), 
								pe_cad(95 downto 88), 
								pe_cad(103 downto 96), 
								pe_cad(111 downto 104), 
								pe_cad(119 downto 112), 
								pe_cad(127 downto 120),
								open, open,
								cb_en_i, rb_en_i,
								diff_en_i, clk_i, rst_i,
								shift_cb_0, shift_rb_0);

CAD0_o(63 downto 0) <= pe_cad(63 downto 0);
CAD0_o(127 downto 64) <= pe_cad(127 downto 64);

end Behavioral;
