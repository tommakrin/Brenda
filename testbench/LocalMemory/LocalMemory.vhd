library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LocalMemory is
    port ( DATA_I : in  std_logic_vector(127 downto 0);
           SRC_SEL: in std_logic_vector(1 downto 0);
			     MEMEN1,MEMEN2,MEMEN3 : in std_logic;
			     RST_I	: in	std_logic;
			     CLK_I	: in  std_logic;
			     LOAD_COL : in std_logic_vector(5 downto 0);
			     LD_COLUMN_EN : in std_logic;
			     CB_O 	: out  std_logic_vector(127 downto 0); --Current block
           RB_O 	: out  std_logic_vector(127 downto 0)  --Reference block
           );
end LocalMemory;

architecture Behavioral of LocalMemory is

---------------Define Components-------------------
--Submemory
component SubMemory is
    port ( clk : in std_logic;
				   rst : in std_logic;
				   loadEn : in std_logic;
				   colsel: in std_logic_vector(3 downto 0);
				   array_in : in std_logic_vector (127 downto 0);
				   array_out : out std_logic_vector (127 downto 0)
			 );
end component;

--6 bit Addressing counter
component x6bit_counter is
    port ( clk : IN STD_LOGIC;
    				   enable : IN STD_LOGIC;
				   reset : IN STD_LOGIC;
				   load : IN STD_LOGIC;
				   l : IN STD_LOGIC_VECTOR(5 downto 0);
				   q : OUT STD_LOGIC_VECTOR(5 downto 0)
			 );
end component;

--Output MUX
component mux3x1 is
	generic
	( N	: integer  :=	128
	);
	port
	(	sel		: in std_logic_vector(1 downto 0);
		data_a	: in  std_logic_vector(N-1 downto 0);
		data_b	: in  std_logic_vector(N-1 downto 0);
		data_c	: in  std_logic_vector(N-1 downto 0);
		data_out : out std_logic_vector(N-1 downto 0)
	);
end component;

--Demux
component LocalMemory_Demux is
	port ( cb0_o  : out std_logic_vector(127 downto 0);
			   rb1_o  : out std_logic_vector(127 downto 0);
			   rb2_o  : out std_logic_vector(127 downto 0);
			   rb3_o  : out std_logic_vector(127 downto 0);
			   sel_i  : in std_logic_vector(1 downto 0);
			   data_i : in std_logic_vector(127 downto 0)
			);
end component;
---------------End Component Definitions-------------

---------------Begin Signal Definitions--------------

signal rb_data_1, rb_data_2, rb_data_3: std_logic_vector(127 downto 0);
signal SubMem1_out, SubMem2_out, SubMem3_out: std_logic_vector(127 downto 0); --Submemory data outputs
signal addr:	std_logic_vector(5 downto 0); -- Addressing signal

---------------End Signal Definitions----------------

begin

DEMUX: LocalMemory_Demux port map (CB_O, rb_data_1, rb_data_2, rb_data_3, SRC_SEL, DATA_I);
  
SUBMEM1: SubMemory port map (CLK_I, RST_I, MEMEN1, addr(3 downto 0), rb_data_1, SubMem1_out);
  
SUBMEM2: SubMemory port map (CLK_I, RST_I, MEMEN2, addr(3 downto 0), rb_data_2, SubMem2_out);
    
SUBMEM3: SubMemory port map (CLK_I, RST_I, MEMEN3, addr(3 downto 0), rb_data_3, SubMem3_out);
      
X6COUNTER: x6bit_counter port map(CLK_I, '1', RST_I, LD_COLUMN_EN, LOAD_COL, addr);

OUT_MUX: mux3x1 port map (addr(5 downto 4), SubMem1_out, SubMem2_out, SubMem3_out, RB_O);

end Behavioral;