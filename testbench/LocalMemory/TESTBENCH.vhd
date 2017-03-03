-- Project Britney
-- Author: Thomas Makryniotis
-- Testbench for Local Memory Unit
-- Run for 700000ps (70 clock cycles)

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;

-- entity declaration for your testbench.Dont declare any ports here
entity LocalMemory_TB is 
end LocalMemory_TB;

architecture Behavioral of LocalMemory_TB is
  
   -- Component Declaration for the Unit Under Test (UUT)
    component LocalMemory  --'test' is the name of the module needed to be tested.

    port ( DATA_I : in  std_logic_vector(127 downto 0);
           SRC_SEL : in  std_logic_vector(1 downto 0);
			     MEMEN1, MEMEN2, MEMEN3 : in std_logic;
			     RST_I	: in	std_logic;
			     CLK_I	: in  std_logic;
			     LOAD_COL : in std_logic_vector(5 downto 0);
			     LD_COLUMN_EN : in std_logic;
           CB_O 	: out  std_logic_vector(127 downto 0); --Current block
           RB_O 	: out  std_logic_vector(127 downto 0) --Reference block
		      );
    end component;
    
   --declare inputs and initialize them
   
   --Control
   signal clk_i: std_logic;
   signal rst_i: std_logic;
   signal memen1, memen2, memen3: std_logic;
   signal load_col: std_logic_vector(5 downto 0);
   signal load_col_en: std_logic;
   signal src_sel: std_logic_vector(1 downto 0);
   
   --Data
   signal data_in: std_logic_vector(127 downto 0);
   
   signal cb_o: std_logic_vector(127 downto 0);
   signal rb_o: std_logic_vector(127 downto 0);
   
   -- Clock period definitions
   constant clk_period : time := 10 ns;

begin
   -- Instantiate the Unit Under Test (UUT)
   uut: LocalMemory port map (data_in, src_sel, memen1, memen2, memen3, rst_i, clk_i, load_col, load_col_en, cb_o, rb_o);
     
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
        src_sel <= "00";  --Set the DEMUX to send the data directly to the PE (Current Block)
        data_in <= x"5a66f4d4557c01e58f03f5ff7a36d35c";
        wait for 10 ns;
        data_in <= x"744a9d726e61c457d9aebe2b6b8c611c";
        wait for 10 ns;
        data_in <= x"9ef4c6abf16d1b81c336c14af6e79c3b";
        wait for 10 ns;
        data_in <= x"dd6ff9702da05e5dad9033c45ca55abb";
        wait for 10 ns;
        data_in <= x"33912670c16dd859d81bf33d563fa5be";
        wait for 10 ns;
        data_in <= x"7b1be71a108e3c57ce7c9160fb85c4dc";
        wait for 10 ns;
        data_in <= x"d9eb83b5f818811cba69871d452fd852";
        wait for 10 ns;
        data_in <= x"1e3c42932d31fed283ca4db3aae52bc9";
        wait for 10 ns;
        data_in <= x"0299e7b052c48fbe9ca7be5805b65ea7";
        wait for 10 ns;
        data_in <= x"cee8a11fdb770b3afff7bb168ed586a2";
        wait for 10 ns;
        data_in <= x"c02474deb26c5fcb2edc018b27acb1c1";
        wait for 10 ns;
        data_in <= x"9a13d57b383f335620bb499bd2be281d";
        wait for 10 ns;
        data_in <= x"9f9ab151b55bb00433e986a11d349286";
        wait for 10 ns;
        data_in <= x"2f8ec3fff56934040554160a4d76491e";
        wait for 10 ns;
        data_in <= x"3eb27198e00e31320332ad7d9cfdc35a";
        wait for 10 ns;
        data_in <= x"bd22cfd35228c4858fc82e63ae9acd25";
        wait for 10 ns;
        
        --Load data into memory.
        --We're going to load 16 128-bit words on first submemory, row-by-row
        
        memen1 <= '1';
        src_sel <= "01";  --Choose the first submemory in the DEMUX
        data_in <= x"5a66f4d4557c01e58f03f5ff7a36d35c";
        wait for 10 ns;
        data_in <= x"744a9d726e61c457d9aebe2b6b8c611c";
        wait for 10 ns;
        data_in <= x"9ef4c6abf16d1b81c336c14af6e79c3b";
        wait for 10 ns;
        data_in <= x"dd6ff9702da05e5dad9033c45ca55abb";
        wait for 10 ns;
        data_in <= x"33912670c16dd859d81bf33d563fa5be";
        wait for 10 ns;
        data_in <= x"7b1be71a108e3c57ce7c9160fb85c4dc";
        wait for 10 ns;
        data_in <= x"d9eb83b5f818811cba69871d452fd852";
        wait for 10 ns;
        data_in <= x"1e3c42932d31fed283ca4db3aae52bc9";
        wait for 10 ns;
        data_in <= x"0299e7b052c48fbe9ca7be5805b65ea7";
        wait for 10 ns;
        data_in <= x"cee8a11fdb770b3afff7bb168ed586a2";
        wait for 10 ns;
        data_in <= x"c02474deb26c5fcb2edc018b27acb1c1";
        wait for 10 ns;
        data_in <= x"9a13d57b383f335620bb499bd2be281d";
        wait for 10 ns;
        data_in <= x"9f9ab151b55bb00433e986a11d349286";
        wait for 10 ns;
        data_in <= x"2f8ec3fff56934040554160a4d76491e";
        wait for 10 ns;
        data_in <= x"3eb27198e00e31320332ad7d9cfdc35a";
        wait for 10 ns;
        data_in <= x"bd22cfd35228c4858fc82e63ae9acd25";
        wait for 20 ns;
        memen1 <= '0';
        
        --Choose the second submemory in the DEMUX
        --We're going to load 16 128-bit words on the second submemory, row-by-row
        memen2 <= '1';
        src_sel <= "10";
        
        data_in <= x"37a606178b2bc2c72afb7c7ec4acad00";
        wait for 10 ns; 
        data_in <= x"d90f2dffb3cd7bb64b46cba31ecf1cd3";
        wait for 10 ns; 
        data_in <= x"2e329b73a9b92e936166c84be7ce3a59";
        wait for 10 ns; 
        data_in <= x"740df7bc2088159b5e43def6f1b930ec";
        wait for 10 ns; 
        data_in <= x"6e4a5aa2189bf541857590876f94104e";
        wait for 10 ns; 
        data_in <= x"dd055289e8dbbc2369eed8c23d9704da";
        wait for 10 ns; 
        data_in <= x"70aa8291980595d873291bd0e260a6d8";
        wait for 10 ns; 
        data_in <= x"79ab2c84aad3b41294e6e694567b063e";
        wait for 10 ns; 
        data_in <= x"17fcb7f29387a300e48f1c489f91e885";
        wait for 10 ns; 
        data_in <= x"b92cccbfd0dbe194c2337f975700547a";
        wait for 10 ns; 
        data_in <= x"54f97a2f7bc37c2553b0d8e4de90b633";
        wait for 10 ns; 
        data_in <= x"53df47ccca031911b65216750cd1346a";
        wait for 10 ns; 
        data_in <= x"e2627dea291898b15171a01142ec6ecb";
        wait for 10 ns; 
        data_in <= x"9eba322028741dedbdd2c0441d506a66";
        wait for 10 ns; 
        data_in <= x"38f3a16455e9d7997f7b8ee378e49cc5";
        wait for 10 ns; 
        data_in <= x"278574a3fbb62fb41b5c78f6754dd3e6";
        wait for 20 ns;
        memen2 <= '0';
        
        --Choose the third submemory in the DEMUX
        memen3 <= '1';
        src_sel <= "11";
        
        load_col_en <= '1'; --Activate memory reading
        --Write-while-read.
        --We're going to load 16 128-bit words on the third submemory, row-by-row, while reading from second submemory
        --wait for 10 ns; 
        data_in <= x"5d432c0dfa0694cbcc9d41e064beedfa";
        load_col <= "010000";
        wait for 10 ns;     
        load_col_en <= '0'; 
        data_in <= x"6d4af36838b54f29ab36ac7c0d2b6d61";
        wait for 10 ns; 
        data_in <= x"8a27c1fde57e00e3f44211480b820299";
        wait for 10 ns; 
        data_in <= x"e46448dfa5e810f94bbb58e98ef2fe99";
        wait for 10 ns; 
        data_in <= x"d2c43e51734d17e5c46fd0a4c33c21e8";
        wait for 10 ns; 
        data_in <= x"5bd9ce433104ba69616628eadc16611a";
        wait for 10 ns; 
        data_in <= x"aec8737653358cf640106ce8afa14036";
        wait for 10 ns; 
        data_in <= x"e349e161514369b6b5fe5dae6ac3795d";
        wait for 10 ns; 
        data_in <= x"2975c6482c9dda8991d0953cd68e3531";
        wait for 10 ns; 
        data_in <= x"38b5a0a3feb10c4718bb8610b51a25dd";
        wait for 10 ns; 
        data_in <= x"5e130aa886a3fbd98e18416550f110da";
        wait for 10 ns; 
        data_in <= x"ed8eb647e6d2be16b08f2b4c3cea953c";
        wait for 10 ns; 
        data_in <= x"115af997f1f2aaf57b1410537201e806";
        wait for 10 ns; 
        data_in <= x"9ffbc78227d10755c363a4c6481f92f7";
        wait for 10 ns; 
        data_in <= x"46abc102a2e1365e7c5833293d2401b4";
        wait for 10 ns; 
        data_in <= x"0a003050cea36f2070f9463d569bf818";
        wait for 20 ns;
        memen3 <= '0';
        
        wait; -- Wait forever.
  end process;

end;