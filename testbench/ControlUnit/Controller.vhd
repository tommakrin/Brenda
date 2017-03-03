library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Controller is

port(	-- Input signals
			count: in std_logic_vector(10 downto 0);
			-- Output signals
			-- Local Memory control signals
			cs_en_wr_mem1, cs_en_wr_mem2, cs_en_wr_mem3: out std_logic; --Enable submemory write
			cs_colcnt: out std_logic_vector(5 downto 0);			         --Set column number to read from
			cs_datasel: out std_logic_vector(1 downto 0);					--Set path for the data in DEMUX
			cs_en_col_load, cs_en_cnt: out std_logic;					   	--Enable load and count for internal counter
			-- SAD Unit control signals
			cs_en_CBData, cs_en_RBData: out std_logic;						--Choose whether the input is CB or RB
			cs_en_DIFF: out std_logic;									  			--Enable calculation of AD
			-- Compare Unit control signals
			cs_en_compare: out std_logic;								   		--Enable comparison
			-- Vector Memory control signals
			cs_en_vecmem: out std_logic;											--Enable vector memory
			-- Generic
			cs_en_rst: out std_logic												--Reset subsystems
			);

end Controller;

architecture Behavioral of Controller is

begin

	process(count)
	
	variable vcount: natural range 0 to 1540;
	
	begin
		vcount := to_integer(unsigned(count));
		case vcount is
        when 1  => cs_datasel <= "00"; cs_en_CBData <= '1'; -- Read from RAM. Send CB data to PE.
		  
		  -- Read from RAM. First submemory fills with RB data.
		  when 17 => cs_datasel <= "01"; cs_en_RBData <= '1'; cs_en_CBData <= '0'; cs_en_wr_mem1 <= '1';
		  
		  -- Read from RAM. Second submemory fills with RB data.
		  -- PE Array reads from first submemory.
		  when 33 => cs_en_wr_mem1 <= '0'; cs_en_wr_mem2 <= '1'; cs_datasel <= "10"; cs_en_col_load <= '1'; cs_colcnt <= "000000";
		  when 34 => cs_en_col_load <= '0';
		    
		  -- Activate AD calculation.
		  -- Read from RAM. Third submemory fills with data.
		  when 48 => cs_en_DIFF <= '1'; cs_datasel <= "11"; cs_en_wr_mem2 <= '0'; cs_en_wr_mem3 <= '1';
		  
		  -- Load SAD to Compare Unit. Comparation enable signal will not go to 0 until end.
		  -- PE reads second submemory data (no need for extra signaling). Level A data reuse.
		  when 49 => cs_en_compare <= '1';
		  
		  -- Load only 16 pixels into submemory 1 on the next cycle. Starting Level B data reuse.
		  when 64 => cs_en_wr_mem3 <= '0'; cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
		  
		  -- Load 16 pixels into submemory 2 on the next cycle.
		  -- Start loading submemory 3 data into PE Array
		  when 65 => cs_en_wr_mem1 <= '0'; cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
		  when 66 => cs_en_wr_mem2 <= '0';
			
			-- Reached 80th cycle.
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 80 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 81 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 96 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 97 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 112 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 113 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 127 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 128 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 143 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 144 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 159 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 160 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 174 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 175 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 190 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 191 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 206 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 207 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 221 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 222 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 237 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 238 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 253 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 254 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 268 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 269 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 284 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 285 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 300 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 301 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 315 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 316 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 331 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 332 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 347 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 348 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 362 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 363 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 378 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 379 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 394 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 395 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 409 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 410 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 425 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 426 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 441 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 442 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 456 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 457 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 472 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 473 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 488 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 489 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 503 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 504 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 519 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 520 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 535 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 536 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 550 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 551 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 566 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 567 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 582 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 583 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 597 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 598 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 613 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 614 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 629 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 630 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 644 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 645 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 660 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 661 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 676 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 677 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 691 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 692 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 707 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 708 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 723 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 724 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 738 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 739 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 754 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 755 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 770 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 771 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 785 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 786 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 801 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 802 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 817 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 818 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 832 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 833 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 848 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 849 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 864 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 865 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 879 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 880 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 895 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 896 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 911 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 912 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 926 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 927 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 942 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 943 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 958 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 959 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 973 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 974 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 989 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 990 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 1005 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 1006 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 1020 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 1021 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 1036 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 1037 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 1052 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 1053 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 1067 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 1068 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 1083 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 1084 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 1099 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 1100 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 1114 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 1115 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 1130 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 1131 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 1146 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 1147 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 1161 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 1162 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 1177 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 1178 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 1193 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 1194 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 1208 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 1209 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 1224 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 1225 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 1240 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 1241 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 1255 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 1256 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 1271 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 1272 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 1287 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 1288 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 1302 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 1303 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 1318 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 1319 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 1334 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 1335 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 1349 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 1350 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 1365 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 1366 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 1381 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 1382 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 1396 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 1397 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 1412 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 1413 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 1428 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 1429 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 1443 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 1444 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 1459 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 1460 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 1475 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 1476 => cs_en_wr_mem2 <= '0';
			-- Start reading submemory 1. Writing only 16 pixels on submemory 3.
			when 1490 => cs_en_col_load <= '1'; cs_colcnt <= "000000"; cs_en_wr_mem3 <= '1'; cs_datasel <= "11";
			when 1491 => cs_en_col_load <= '0'; cs_en_wr_mem3 <= '0';
			-- Start reading submemory 2. Writing only 16 pixels on submemory 1.
			when 1506 => cs_en_wr_mem1 <= '1'; cs_datasel <= "01";
			when 1507 => cs_en_wr_mem1 <= '0';
			-- Start reading submemory 3. Writing only 16 pixels on submemory 2.
			when 1522 => cs_en_wr_mem2 <= '1'; cs_datasel <= "10";
			when 1523 => cs_en_wr_mem2 <= '0';
			
			--Storing Actual Motion Vector (AMV)
			when 1540 => cs_en_vecmem <= '1'; cs_en_rst <= '1';
			
      when others => cs_en_rst <= '0'; null;
		end case;
	end process;

end Behavioral;