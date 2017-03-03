library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SAD_Unit is

port( --Input signals
      --Control Signals
		CB_INPUT_EN_i  : in std_logic;
		RB_INPUT_EN_i  : in std_logic;
		DIFF_EN_i		: in std_logic;
		CLK				: in std_logic;
		RESET				: in std_logic; 
		--Data Signals
		CB_DATA_i		: in std_logic_vector(127 downto 0);
		RB_DATA_i		: in std_logic_vector(127 downto 0);
		--Output signals
		SUM				: out std_logic_vector(15 downto 0)
  );

end SAD_Unit;

architecture Behavioral of SAD_Unit is

-- Declare Components

component PE_ARRAY_16X16 is
	port( --Output signals
			CAD_o : out std_logic_vector(2047 downto 0);
			--Input signals
			cb_en_i : in std_logic;
			rb_en_i : in std_logic;
			diff_en_i: in std_logic;
			clk_i : in std_logic;
			rst_i : in std_logic;
			--Data Signals
			CB_i : in std_logic_vector(127 downto 0);
			RB_i : in std_logic_vector(127 downto 0)
		);
end component;

component TreeAdder is
	port ( AD_DATA : in  STD_LOGIC_VECTOR (2047 downto 0);
          SAD : out  STD_LOGIC_VECTOR (15 downto 0));
end component;

-- Internal signal declaration
signal intdata: std_logic_vector(2047 downto 0);

begin

	PE:   PE_ARRAY_16X16 port map (intdata, CB_INPUT_EN_i, RB_INPUT_EN_i, 
											 DIFF_EN_i, CLK, RESET, CB_DATA_i, RB_DATA_i);
	TREE: TreeAdder port map (intdata, SUM);
	
end Behavioral;

