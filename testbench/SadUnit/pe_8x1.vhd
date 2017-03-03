----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:41:47 04/12/2016 
-- Design Name: 
-- Module Name:    pe_2x1 - Behavioral 
-- Project Name: 
-- Target Devices: Spartan 3 Series
-- Tool versions: 
-- Description: 8x1 Processing Array
--
-- Dependencies: pe.vhd
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pe_8x1 is
  port(--Output signals
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
end pe_8x1;

architecture Behavioral of pe_8x1 is

--------Define Components-----------

component pe is
  port (
    --Output signals
    DIFF_O      : out std_logic_vector (7 downto 0);
    CB_NEXT_O   : out std_logic_vector (7 downto 0);
    RB_NEXT_O   : out std_logic_vector (7 downto 0);
    --Input signals
    -- Control
    EN_SHIFT_CB_I  : in  std_logic;
    EN_SHIFT_RB_I  : in  std_logic;
    EN_DIFF        : in  std_logic;
    CLK_I          : in  std_logic;
    RST_I          : in  std_logic;
	 -- Data
    CB_in       : in  std_logic_vector (7 downto 0);
    RB_in       : in  std_logic_vector (7 downto 0)
    );
end component;

-----Component Definitions End ----

----- Define Internal Signals -----
signal pe_cad: std_logic_vector(63 downto 0); --Concatenated Absolute Diff
--Intermediate signals. For 8 PEs we need 7 intermediate signals.
signal shift_cb_0: std_logic_vector(7 downto 0);
signal shift_rb_0: std_logic_vector(7 downto 0);

signal shift_cb_1: std_logic_vector(7 downto 0);
signal shift_rb_1: std_logic_vector(7 downto 0);

signal shift_cb_2: std_logic_vector(7 downto 0);
signal shift_rb_2: std_logic_vector(7 downto 0);

signal shift_cb_3: std_logic_vector(7 downto 0);
signal shift_rb_3: std_logic_vector(7 downto 0);

signal shift_cb_4: std_logic_vector(7 downto 0);
signal shift_rb_4: std_logic_vector(7 downto 0);

signal shift_cb_5: std_logic_vector(7 downto 0);
signal shift_rb_5: std_logic_vector(7 downto 0);

signal shift_cb_6: std_logic_vector(7 downto 0);
signal shift_rb_6: std_logic_vector(7 downto 0);

----- Internal Signal Definitions End -----

begin
  P0: pe port map (pe_cad(7 downto 0), shift_cb_0, shift_rb_0, cb_en_i, rb_en_i, 
									diff_en_i, clk_i, rst_i, CB_i, RB_i);
									
  P1: pe port map (pe_cad(15 downto 8), shift_cb_1, shift_rb_1, cb_en_i, rb_en_i, 
									diff_en_i, clk_i, rst_i, shift_cb_0, shift_rb_0);
									
  P2: pe port map (pe_cad(23 downto 16), shift_cb_2, shift_rb_2, cb_en_i, rb_en_i, 
									diff_en_i, clk_i, rst_i, shift_cb_1, shift_rb_1);
									
  P3: pe port map (pe_cad(31 downto 24), shift_cb_3, shift_rb_3, cb_en_i, rb_en_i, 
									diff_en_i, clk_i, rst_i, shift_cb_2, shift_rb_2);
									
  P4: pe port map (pe_cad(39 downto 32), shift_cb_4, shift_rb_4, cb_en_i, rb_en_i, 
									diff_en_i, clk_i, rst_i, shift_cb_3, shift_rb_3);
									
  P5: pe port map (pe_cad(47 downto 40), shift_cb_5, shift_rb_5, cb_en_i, rb_en_i, 
									diff_en_i, clk_i, rst_i, shift_cb_4, shift_rb_4);
									
  P6: pe port map (pe_cad(55 downto 48), shift_cb_6, shift_rb_6, cb_en_i, rb_en_i, 
									diff_en_i, clk_i, rst_i, shift_cb_5, shift_rb_5);
									--Change the following ïpen ports to the SHIFT output signals,
									--if you want to extend the design.
  P7: pe port map (pe_cad(63 downto 56), SHIFT_CB_o, SHIFT_RB_o, cb_en_i, rb_en_i, 
   								diff_en_i, clk_i, rst_i, shift_cb_6, shift_rb_6);

AD0_o <= pe_cad(7 downto 0);
AD1_o <= pe_cad(15 downto 8);
AD2_o <= pe_cad(23 downto 16);
AD3_o <= pe_cad(31 downto 24);
AD4_o <= pe_cad(39 downto 32);
AD5_o <= pe_cad(47 downto 40);
AD6_o <= pe_cad(55 downto 48);
AD7_o <= pe_cad(63 downto 56);

end Behavioral;