-- Project Britney
-- Author: Thomas Makryniotis
-- Testbench for SAD UNIT. Run for 380000ps (38 cycles needed)
-- Be careful about how you read the data!
-- The data used for testing the circuit can be found in: (url)


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;

-- entity declaration for your testbench.Dont declare any ports here
entity SAD_TB is 
end SAD_TB;

architecture Behavioral of SAD_TB is
  
   -- Component Declaration for the Unit Under Test (UUT)
    component SAD_Unit  --'test' is the name of the module needed to be tested.

    port( --Input signals
          --Control Signals
		      CB_INPUT_EN_i  : in std_logic;
		      RB_INPUT_EN_i  : in std_logic;
		      DIFF_EN_i		    : in std_logic;
		      CLK				        : in std_logic;
		      RESET				      : in std_logic; 
		      --Data Signals
		      CB_DATA_i		    : in std_logic_vector(127 downto 0);
		      RB_DATA_i		    : in std_logic_vector(127 downto 0);
		      --Output signals
		      SUM				        : out std_logic_vector(15 downto 0)
        );
  end component;
  
   --declare inputs and initialize them
   
   --Control
   signal clk_i   : std_logic;
   signal rst_i   : std_logic;
   signal cb_en   : std_logic;
   signal rb_en   : std_logic;
   signal diff_en : std_logic;
   
   --Data
   signal cb_i: std_logic_vector(127 downto 0);
   signal rb_i: std_logic_vector(127 downto 0);
   signal res  : std_logic_vector(15 downto 0);
   
   -- Clock period definitions
   constant clk_period : time := 10 ns;

begin
   -- Instantiate the Unit Under Test (UUT)
   uut: SAD_Unit port map (cb_en, rb_en, diff_en, clk_i, rst_i, cb_i, rb_i, res);
     
   -- Clock process definitions( clock with 50% duty cycle is generated here).
   clk_process :process
   begin
        clk_i <= '1';
        wait for clk_period/2;  --for 0.5 ns signal is '0'.
        clk_i <= '0';
        wait for clk_period/2;  --for next 0.5 ns signal is '1'.
   end process;
           
   -- Stimulus process
  stim_proc: process
   begin
        --Reset system             
        wait for 7 ns;
        rst_i <= '1';
        wait for 3 ns;
        rst_i <='0';
        
        -- Transfer the CB data directly to the AD processor.
        wait for 20 ns;
        cb_en <= '1'; --Enable CB data
        
        cb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        cb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        cb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        cb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        cb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        cb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        cb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        cb_i <= x"07030403030203080503030a03070c0f";
        wait for 10 ns;
        cb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        cb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        cb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        cb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        cb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        cb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        cb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        cb_i <= x"00000000000000000000000000000000";
        wait for 20 ns;
        cb_en <= '0'; --Disable CB data
        
        --Load RB data
        
        rb_en <= '1'; --Enable RB data
                  
        rb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        rb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        rb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        rb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        rb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        rb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        rb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        rb_i <= x"0101050705060505050405010d030501";
        wait for 10 ns;
        rb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        rb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        rb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        rb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        rb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        rb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        rb_i <= x"00000000000000000000000000000000";
        wait for 10 ns;
        rb_i <= x"00000000000000000000000000000000";
        wait for 20 ns;
        rb_en <= '0'; --Disable RB data
        
        diff_en <= '1'; --Activate diff calc
        wait for 10 ns;
        diff_en <= '0';
        
        wait; -- Wait forever.
  end process;
end;