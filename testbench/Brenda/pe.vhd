LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity pe is
  port(
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
end pe;

architecture behavioral of pe is

  -- Internal signal definitions
  signal CBR : std_logic_vector(7 downto 0);
  signal RBR : std_logic_vector(7 downto 0);
  signal MEMORY : std_logic_vector(7 downto 0);

begin

  process (CLK_I, RST_I)
  begin
  
    -- Reset subsystems asynchronously
    if (RST_I = '1') then
		  CBR <= "00000000";
		  RBR <= "00000000";
    elsif (rising_edge(CLK_I)) then
      if (EN_SHIFT_CB_I = '1') then
	     CBR <= CB_in;
	    elsif (EN_SHIFT_RB_I = '1') then
 	     RBR <= RB_in;
 	    end if;
 	  end if;
  end process;

  -- Calculate AD
  --DIFF_O <= std_logic_vector(to_unsigned(abs((to_integer(unsigned(CBR)) - to_integer(unsigned(RBR)))),8)) when (EN_DIFF = '1' and EN_SHIFT_RB_I = '0' and EN_SHIFT_CB_I = '0') else
  --          "00000000";
  MEMORY <= std_logic_vector(to_unsigned(abs((to_integer(unsigned(CBR)) - to_integer(unsigned(RBR)))),8)) when (EN_DIFF = '1') else MEMORY;
  DIFF_O <= MEMORY;
  CB_NEXT_O <= CBR;
  RB_NEXT_O <= RBR;
  
end behavioral; 