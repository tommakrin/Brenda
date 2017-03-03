LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;

-- entity declaration for your testbench.Dont declare any ports here
entity BRITNEY_TB is 
end BRITNEY_TB;

architecture Behavioral of BRITNEY_TB is
  
   -- Component Declaration for the Unit Under Test (UUT)
    component BRITNEY  --'test' is the name of the module needed to be tested.

    port ( DATA_IN 				: in std_logic_vector(127 downto 0);
			     OK, CLOCK, RESET 	: in std_logic;
			     VECTOR					: out std_logic_vector(10 downto 0)
			    );
    end component;
    
   --declare inputs and initialize them
   
   --Control
   signal data_feed       : std_logic_vector(127 downto 0);
   signal start, clk, rst : std_logic;
   signal mvector         : std_logic_vector(10 downto 0);
   
   -- Clock period definitions
   constant clk_period : time := 10 ns;

begin
   -- Instantiate the Unit Under Test (UUT)
   uut: BRITNEY port map (DATA_IN => data_feed,
                          OK      => start,
                          CLOCK   => clk,
                          RESET   => rst,
                          VECTOR  => mvector);
     
   -- Clock process definitions( clock with 50% duty cycle is generated here).
   clk_process :process
   begin
        clk <= '1';
        wait for clk_period/2;  --for 0.5 ns signal is '0'.
        clk <= '0';
        wait for clk_period/2;  --for next 0.5 ns signal is '1'.
   end process;
           
   -- Stimulus process
  stim_proc: process
   begin
        --Reset system             
        wait for 7 ns;
        rst <= '1';
        wait for 3 ns;
        rst <='0';
        
        -- Feed CB data
        wait for 20 ns; --Initial wait. Offset 3 cycles.
        start <= '1';
        
        
        
        
        data_feed <= x"10101010101010101010101010101010";
        wait for 10 ns;
        data_feed <= x"22222222222222222222222222222222";
        wait for 10 ns;
        data_feed <= x"20202020202020202020202020202020";
        wait for 10 ns;
        data_feed <= x"12121212121212121212121212121212";
        wait for 10 ns;
        data_feed <= x"12121212121212121212121212121212";
        wait for 10 ns;
        data_feed <= x"12121212121212121212121212121212";
        wait for 10 ns;
        data_feed <= x"10101010101010101010101010101010";
        wait for 10 ns;
        data_feed <= x"20202020202020202020202020202020";
        wait for 10 ns;
        data_feed <= x"22222222222222222222222222222222";
        wait for 10 ns;
        data_feed <= x"22222222222222222222222222222222";
        wait for 10 ns;
        data_feed <= x"20202020202020202020202020202020";
        wait for 10 ns;
        data_feed <= x"12121212121212121212121212121212";
        wait for 10 ns;
        data_feed <= x"10101010101010101010101010101010";
        wait for 10 ns;
        data_feed <= x"11111111111111111111111111111111";
        wait for 10 ns;
        data_feed <= x"11111111111111111111111111111111";
        wait for 10 ns;
        data_feed <= x"11111111111111111111111111111111";
        wait for 10 ns; -- 16th cycle
        
        
        -- Feed initial RB data into submemory 1.
        
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 20 ns; --33rd cycle
        
        -- Feed initial RB data into submemory 2.
        
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns; 
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns; 
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns; 
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns; 
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns; 
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns; 
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns; 
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns; 
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns; 
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns; 
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns; 
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns; 
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns; 
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns; 
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns; 
        data_feed <= x"22222020201212101022222222111111";
        wait for 20 ns;--50th cycle
        
        -- Feed initial RB data into submemory 3.
        
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns;     
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns; 
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns; 
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns; 
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns; 
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns; 
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns; 
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns; 
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns; 
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns; 
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns; 
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns; 
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns; 
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns; 
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns; 
        data_feed <= x"22222222221111111122222222111111";
        wait for 20 ns; --Cycle #67
        
        -- Load 16 pels into SUBMEM 1. -- Cycle 68
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns; -- End of clk cycle #68
        -- Load 16 pels into SUBMEM 2.
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns; -- End of clk cycle #69
        wait for 140 ns; -- cycle #83
        -- Load 16 pels into SUBMEM 3.
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns; -- End of clk cycle #84
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns; --#99
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns; --#100
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns; --#115
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns; --#131
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022221022201212";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"12102022222012101111112222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022221022201212";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"12102022222012101111112222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022221022201212";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"12102022222012101111112222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022221022201212";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"12102022222012101111112222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022221022201212";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"12102022222012101111112222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022221022201212";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"12102022222012101111112222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022221022201212";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"12102022222012101111112222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022221022201212";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"12102022222012101111112222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022221022201212";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"12102022222012101111112222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022221022201212";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"12102022222012101111112222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022221022201212";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"12102022222012101111112222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022221022201212";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"12102022222012101111112222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022221022201212";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"12102022222012101111112222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022221022201212";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"12102022222012101111112222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022221022201212";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"12102022222012101111112222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022221022201212";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"12102022222012101111112222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns;
        
        -- Load 16 pels into SUBMEM 1 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101020222222101111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 2 - 16 cycles.
        wait for 150 ns;
        data_feed <= x"22222020201212101022222222111111";
        wait for 10 ns;
        -- Load 16 pels into SUBMEM 3 - 15 cycles.
        wait for 140 ns;
        data_feed <= x"22222222221111111122222222111111";
        wait for 10 ns;
        start <= '0';
        
        wait for 400 ns; -- Safeguard.
        
        wait; -- Wait forever.
  end process;

end;


