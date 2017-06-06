library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Controller is

port(	-- Input signals
			count: in std_logic_vector(10 downto 0);
			-- Output signals
			-- Local Memory control signals
			cs_en_wr_mem1, cs_en_wr_mem2, cs_en_wr_mem3: out std_logic; --Enable submemory write
			cs_colcnt: out std_logic_vector(5 downto 0);			--Set column number to read from
			cs_datasel: out std_logic_vector(1 downto 0);			--Set path for the data in DEMUX
			cs_en_col_load, cs_en_cnt: out std_logic;			--Enable load and count for internal counter
			-- SAD Unit control signals
			cs_en_CBData, cs_en_RBData: out std_logic;			--Choose whether the input is CB or RB
			cs_en_DIFF: out std_logic;									  			--Enable calculation of AD
			-- Compare Unit control signals
			cs_en_compare: out std_logic;					--Enable comparison
			-- Vector Memory control signals
			cs_en_vecmem: out std_logic;					--Enable vector memory
			-- Generic
			cs_en_rst: out std_logic												--Reset subsystems
			);

end Controller;

architecture Behavioral of Controller is

begin

	process(count)
	
	variable vcount: natural range 0 to 1544;
	
	begin
		vcount := to_integer(unsigned(count));
		case vcount is
        when 1  => cs_datasel <= "00"; cs_en_CBData <= '1'; -- Read from RAM. Send CB data to PE.
		  
		  -- Read from RAM. First submemory fills with RB data.
		  when 17 => cs_datasel <= "01"; cs_en_RBData <= '1'; cs_en_CBData <= '0'; cs_en_wr_mem1 <= '1';
		  
		  -- Read from RAM. Second submemory fills with RB data.
		  -- PE Array reads from first submemory.
		  when 34 => cs_en_wr_mem1 <= '0'; cs_en_wr_mem2 <= '1'; cs_datasel <= "10"; cs_en_col_load <= '1'; cs_colcnt <= "000000"; 
		  when 35 => cs_en_col_load <= '0';
		    
		  -- Activate AD calculation.
		  -- Read from RAM. Third submemory fills with data.
		 --when 50 => cs_en_DIFF <= '1';
		  
		  -- Load SAD to Compare Unit. Comparation enable signal will not go to 0 until end.
		  -- PE reads second submemory data (no need for extra signaling). Level A data reuse.
		  when 51 => cs_en_wr_mem2 <= '0'; cs_en_wr_mem3 <= '1'; cs_datasel <= "11"; cs_en_DIFF <= '1';
		  when 52 => cs_en_compare <= '1';
		  		  
		  -- Load only 16 pixels into submemory 1 on the next cycle. Starting Level B data reuse.
		  when 67 => cs_en_wr_mem3 <= '0'; 
		  
		  -- Load 16 pixels into submemory 2 on the next cycle.
		  -- Start loading submemory 3 data into PE Array
		  when 68 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
		  when 69 => cs_en_wr_mem1 <= '0'; cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
		  when 70 => cs_en_wr_mem2 <= '0'; 

			-- Reached 81st cycle.

-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 81 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 82 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 84 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 85 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 98 => cs_en_DIFF <= '1';
when 100 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 101 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 116 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 117 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 128 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 129 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 131 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 132 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 145 => cs_en_DIFF <= '1';
when 147 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 148 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 163 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 164 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 175 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 176 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 178 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 179 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 192 => cs_en_DIFF <= '1';
when 194 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 195 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 210 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 211 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 222 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 223 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 225 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 226 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 239 => cs_en_DIFF <= '1';
when 241 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 242 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 257 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 258 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 269 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 270 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 272 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 273 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 286 => cs_en_DIFF <= '1';
when 288 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 289 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 304 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 305 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 316 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 317 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 319 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 320 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 333 => cs_en_DIFF <= '1';
when 335 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 336 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 351 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 352 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 363 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 364 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 366 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 367 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 380 => cs_en_DIFF <= '1';
when 382 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 383 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 398 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 399 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 410 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 411 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 413 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 414 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 427 => cs_en_DIFF <= '1';
when 429 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 430 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 445 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 446 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 457 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 458 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 460 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 461 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 474 => cs_en_DIFF <= '1';
when 476 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 477 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 492 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 493 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 504 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 505 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 507 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 508 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 521 => cs_en_DIFF <= '1';
when 523 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 524 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 539 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 540 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 551 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 552 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 554 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 555 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 568 => cs_en_DIFF <= '1';
when 570 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 571 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 586 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 587 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 598 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 599 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 601 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 602 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 615 => cs_en_DIFF <= '1';
when 617 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 618 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 633 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 634 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 645 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 646 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 648 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 649 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 662 => cs_en_DIFF <= '1';
when 664 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 665 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 680 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 681 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 692 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 693 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 695 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 696 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 709 => cs_en_DIFF <= '1';
when 711 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 712 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 727 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 728 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 739 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 740 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 742 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 743 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 756 => cs_en_DIFF <= '1';
when 758 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 759 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 774 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 775 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 786 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 787 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 789 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 790 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 803 => cs_en_DIFF <= '1';
when 805 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 806 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 821 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 822 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 833 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 834 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 836 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 837 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 850 => cs_en_DIFF <= '1';
when 852 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 853 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 868 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 869 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 880 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 881 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 883 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 884 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 897 => cs_en_DIFF <= '1';
when 899 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 900 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 915 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 916 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 927 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 928 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 930 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 931 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 944 => cs_en_DIFF <= '1';
when 946 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 947 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 962 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 963 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 974 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 975 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 977 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 978 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 991 => cs_en_DIFF <= '1';
when 993 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 994 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 1009 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 1010 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 1021 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 1022 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 1024 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 1025 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 1038 => cs_en_DIFF <= '1';
when 1040 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 1041 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 1056 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 1057 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 1068 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 1069 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 1071 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 1072 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 1085 => cs_en_DIFF <= '1';
when 1087 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 1088 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 1103 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 1104 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 1115 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 1116 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 1118 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 1119 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 1132 => cs_en_DIFF <= '1';
when 1134 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 1135 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 1150 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 1151 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 1162 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 1163 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 1165 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 1166 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 1179 => cs_en_DIFF <= '1';
when 1181 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 1182 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 1197 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 1198 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 1209 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 1210 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 1212 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 1213 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 1226 => cs_en_DIFF <= '1';
when 1228 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 1229 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 1244 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 1245 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 1256 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 1257 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 1259 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 1260 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 1273 => cs_en_DIFF <= '1';
when 1275 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 1276 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 1291 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 1292 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 1303 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 1304 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 1306 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 1307 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 1320 => cs_en_DIFF <= '1';
when 1322 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 1323 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 1338 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 1339 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 1350 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 1351 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 1353 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 1354 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 1367 => cs_en_DIFF <= '1';
when 1369 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 1370 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 1385 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 1386 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 1397 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 1398 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 1400 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 1401 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 1414 => cs_en_DIFF <= '1';
when 1416 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 1417 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 1432 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 1433 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 1444 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 1445 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 1447 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 1448 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 1461 => cs_en_DIFF <= '1';
when 1463 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 1464 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 1479 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 1480 => cs_en_wr_mem2 <= '0';
-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
when 1491 => cs_en_col_load <= '1'; cs_colcnt <= "000000";
when 1492 => cs_en_DIFF <= '0'; cs_en_col_load <= '0';
when 1494 => cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
when 1495 => cs_en_wr_mem3 <= '0';
-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
when 1508 => cs_en_DIFF <= '1';
when 1510 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
when 1511 => cs_en_wr_mem1 <= '0';
-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
when 1526 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
when 1527 => cs_en_wr_mem2 <= '0';
			
			--Storing Actual Motion Vector (AMV)
			when 1541 => cs_en_vecmem <= '1'; cs_en_compare <= '0';
			when 1543 => cs_en_rst <= '1';
			
      when others => cs_en_rst <= '0'; null;
		end case;
	end process;

end Behavioral;
