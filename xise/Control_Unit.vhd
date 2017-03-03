library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Control_Unit is

	port(	-- Input signals
			  RESET: in std_logic;
			  CLOCK: in std_logic;
			  START: in std_logic;
			
			  -- Output signals
			  -- Local Memory control signals
			  WE1, WE2, WE3: out std_logic;                --Enable submemory write
			  LOAD_COL: out std_logic_vector(5 downto 0);		--Set column number to read from
			  POS: out std_logic_vector(10 downto 0);
			  SRC_SEL: out std_logic_vector(1 downto 0);			--Set path for the data in DEMUX
			  EN_LOAD_COL, en_cnt: out std_logic;					     --Enable load and count for internal counter
			
			  -- SAD Unit control signals
			  CB_EN, RB_EN: out std_logic;					            --Choose whether the input is CB or RB
			  DIFF_EN: out std_logic;									             --Enable calculation of AD
			
			  -- Compare Unit control signals
			  EN_COMPARE: out std_logic;								           --Enable comparison
			
			  -- Vector Memory control signals
			  EN_VECMEM: out std_logic;									           --Enable vector memory
			
			  -- Generic
			  EN_RST: out std_logic										              --Reset subsystems
			);

end Control_Unit;

architecture Behavioral of Control_Unit is

-- Component declaration

-- Up counter
component x11bit_counter is
	port (	clk:		in  std_logic;                     -- Input clock
				 enable:	in  std_logic;                   -- Enable counting
				 reset:	in  std_logic;                    -- Input reset   
				 q: 		out std_logic_vector (10 downto 0)  -- Output of the counter  
			  );
end component;

-- Controller
component Controller is
port(	-- Count state input
			count: in std_logic_vector(10 downto 0);
			
			-- Memory signals
			cs_en_wr_mem1, cs_en_wr_mem2, cs_en_wr_mem3: out std_logic;
			cs_colcnt: out std_logic_vector(5 downto 0);
			cs_datasel: out std_logic_vector(1 downto 0);
			cs_en_col_load, cs_en_cnt: out std_logic;
			
			--SAD Unit signals
			cs_en_CBData, cs_en_RBData: out std_logic;
			cs_en_DIFF: out std_logic;
			
			-- Compare/Vecmem signals
			cs_en_compare: out std_logic;
			cs_en_vecmem: out std_logic;

			-- Reset
			cs_en_rst: out std_logic
			);
end component;

-- Declare signals
signal cnt: std_logic_vector(10 downto 0);
signal internal_reset: std_logic;
signal ctrl_reset: std_logic;

begin

internal_reset <= RESET OR ctrl_reset; -- ORing internal and external reset signals
EN_RST  <= internal_reset;             -- Assigning internal reset to output pin
POS <= cnt;                            -- Position has value directly from counter

SYSCOUNT: x11bit_counter port map (CLOCK, START, internal_reset, cnt);
SYSCTRL: Controller port map (count           => cnt,
                              cs_en_wr_mem1   => WE1,
                              cs_en_wr_mem2   => WE2,
                              cs_en_wr_mem3   => WE3,
                              cs_colcnt       => LOAD_COL,
                              cs_datasel      => SRC_SEL,
                              cs_en_col_load  => EN_LOAD_COL,
                              cs_en_cnt       => open,
                              cs_en_CBData    => CB_EN,
                              cs_en_RBData    => RB_EN,
                              cs_en_DIFF      => DIFF_EN,
                              cs_en_compare   => EN_COMPARE,
                              cs_en_vecmem    => EN_VECMEM,
                              cs_en_rst     => ctrl_reset
                              );
											
end Behavioral;