----------------------------------------------------------------------------------
-- Company: University of Western Macedonia - ICTE - LDSCA
-- Engineer: Thomas Makryniotis
-- 
-- Create Date:    03:53:09 04/12/2016 
-- Design Name: 
-- Module Name:    BRITNEY - Behavioral 
-- Project Name: 	 BRITNEY
-- Target Devices: Xilinx Family - Spartan 3E
-- Description: Motion estimation unit for use in FPGA
--
-- Revision: 
-- Revision 0.02 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.ALL;

entity BRITNEY is
	port ( DATA_IN 				: in std_logic_vector(127 downto 0);
			 OK, CLOCK, RESET 	: in std_logic;
			 VECTOR					: out std_logic_vector(10 downto 0));
end BRITNEY;

architecture Behavioral of BRITNEY is

-- Component Declaration

-- LocalMemory + DEMUX
component LocalMemory is
	port (  DATA_I 	: in  std_logic_vector(127 downto 0);
           SRC_SEL	: in	std_logic_vector(1 downto 0);
			  MEMEN1,MEMEN2,MEMEN3 : in std_logic;
			  RST_I		: in	std_logic;
			  CLK_I		: in  std_logic;
			  LOAD_COL 	: in	std_logic_vector(5 downto 0);
			  LD_COLUMN_EN : in std_logic;
			  CB_O 		: out  std_logic_vector(127 downto 0); --Current block
           RB_O 		: out  std_logic_vector(127 downto 0)  --Reference block
			  );
end component;

-- SAD Unit
component SAD_Unit is
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
end component;

-- Compare Unit
component COMPARE_Unit is
	port( POSITION	: in std_logic_vector(10 downto 0);
			SAD		: in std_logic_vector(15 downto 0);
			LOAD_EN	: in std_logic;
			CLK		: in std_logic;
			RESET		: in std_logic;
			MINPOS	: out std_logic_vector(10 downto 0)
			);
end component;

--Motion Vector Memory
component Motion_Vector_Memory is
	port( clk 	: in std_logic;
			rst 	: in std_logic;
			din 	: in std_logic_vector(10 downto 0);
			wr_en : in std_logic;
			rd_en : in std_logic;
			dout 	: out std_logic_vector(10 downto 0);
			full 	: out std_logic;
			empty : out std_logic;
			data_count : out std_logic_vector(10 downto 0)
			);
end component;

--Control Unit
component Control_Unit is
	port(	  -- Input signals
			  RESET: in std_logic;
			  CLOCK: in std_logic;
			  START: in std_logic;
			
			  -- Output signals
			  -- Local Memory control signals
			  WE1, WE2, WE3	: out std_logic;           --Enable submemory write
			  LOAD_COL			: out std_logic_vector(5 downto 0);    --Set column number to read from
			  POS					: out std_logic_vector(10 downto 0);
			  SRC_SEL			: out std_logic_vector(1 downto 0);	   --Set path for the data in DEMUX
			  EN_LOAD_COL, en_cnt: out std_logic;			--Enable load and count for internal counter
			
			  -- SAD Unit control signals
			  CB_EN, RB_EN		: out std_logic;				--Choose whether the input is CB or RB
			  DIFF_EN			: out std_logic;				--Enable calculation of AD
			
			  -- Compare Unit control signals
			  EN_COMPARE		: out std_logic;				--Enable comparison
			
			  -- Vector Memory control signals
			  EN_VECMEM			: out std_logic;				--Enable vector memory
			
			  -- Generic
			  EN_RST				: out std_logic				--Reset subsystems
			);

end component;

-- Internal Signals
-- Datapath
signal cb_data_to_sadunit: std_logic_vector(127 downto 0);
signal rb_data_to_sadunit: std_logic_vector(127 downto 0);
signal sadunit_sum:			std_logic_vector(15 downto 0);
signal min_sad_position:	std_logic_vector(10 downto 0);
-- Control
-- Memory
signal ctrl_write_en_1:		std_logic;
signal ctrl_write_en_2:		std_logic;
signal ctrl_write_en_3:		std_logic;
signal ctrl_load_col_number:	std_logic_vector(5 downto 0);
signal ctrl_select_demux_path:	std_logic_vector(1 downto 0);
signal ctrl_col_load_enable:	std_logic;
--signal ctrl_count_enable:	std_logic;
-- SAD
signal ctrl_enable_cb_path:	std_logic;
signal ctrl_enable_rb_path:	std_logic;
signal ctrl_enable_diff:		std_logic;
-- Other components
signal ctrl_current_position: std_logic_vector(10 downto 0);
signal ctrl_enable_compare:	std_logic;
signal ctrl_write_en_vector_memory:	std_logic;
signal ctrl_reset:	std_logic;

begin

MEMORY: LocalMemory port map( DATA_I	=> DATA_IN,
									   SRC_SEL	=> ctrl_select_demux_path,
									   MEMEN1	=> ctrl_write_en_1,
									   MEMEN2	=> ctrl_write_en_2,
									   MEMEN3	=> ctrl_write_en_3,
									   RST_I		=> ctrl_reset,
									   CLK_I 	=> CLOCK,
									   LOAD_COL => ctrl_load_col_number,
									   LD_COLUMN_EN => ctrl_col_load_enable,
									   CB_O		=> cb_data_to_sadunit,
									   RB_O		=> rb_data_to_sadunit);
									
SADUNIT: SAD_Unit port map( CB_INPUT_EN_i => ctrl_enable_cb_path,
									 RB_INPUT_EN_i => ctrl_enable_rb_path,
									 DIFF_EN_i		=> ctrl_enable_diff,
									 CLK				=> CLOCK,
									 RESET			=> ctrl_reset,
									 CB_DATA_i		=> cb_data_to_sadunit,
									 RB_DATA_i		=> rb_data_to_sadunit,
									 SUM				=> sadunit_sum);
									 
COMPARATOR: COMPARE_Unit port map( POSITION	=> ctrl_current_position,
											  SAD			=> sadunit_sum,
											  LOAD_EN	=> ctrl_enable_compare,
											  CLK			=> CLOCK,
											  RESET		=> ctrl_reset,
											  MINPOS		=> min_sad_position);
											  
MVMEMORY: Motion_Vector_Memory port map( clk		=> CLOCK,
													  rst		=> ctrl_reset,
													  din		=> min_sad_position,
													  wr_en	=> ctrl_write_en_vector_memory,
													  rd_en	=>	'1',
													  dout	=> VECTOR,
													  full	=> OPEN,
													  empty	=> OPEN,
													  data_count => OPEN);

CONTROLUNIT: Control_Unit port map( RESET	=> RESET,
												CLOCK	=> CLOCK,
												START	=> OK,
												WE1	=> ctrl_write_en_1,
												WE2	=> ctrl_write_en_2,
												WE3	=> ctrl_write_en_3,
												LOAD_COL	=> ctrl_load_col_number,
												POS		=> ctrl_current_position,
												SRC_SEL	=> ctrl_select_demux_path,
												EN_LOAD_COL	=> ctrl_col_load_enable,
												en_cnt	=> OPEN, --Intentionally open
												CB_EN		=>	ctrl_enable_cb_path,
												RB_EN		=> ctrl_enable_rb_path,
												DIFF_EN	=> ctrl_enable_diff,
												EN_COMPARE	=> ctrl_enable_compare,
												EN_VECMEM	=> ctrl_write_en_vector_memory,
												EN_RST	=> ctrl_reset);

end Behavioral;