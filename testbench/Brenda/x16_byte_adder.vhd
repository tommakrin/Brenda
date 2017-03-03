library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity x16_byte_adder is
  port ( data_i : in std_logic_vector(127 downto 0);
		     sum_12bit_o : out std_logic_vector(11 downto 0)
		    );
end x16_byte_adder;

architecture Behavioral of x16_byte_adder is

--Declare components
component four_byte_adder is

	port( --Input signals
			a_byte_in: in std_logic_vector(7 downto 0);
			b_byte_in: in std_logic_vector(7 downto 0);
			c_byte_in: in std_logic_vector(7 downto 0);
			d_byte_in: in std_logic_vector(7 downto 0);
			cin: in std_logic;
			--Output signals
			val9bit_out: out std_logic_vector(9 downto 0)
	);
end component;

component four_10bit_word_adder is

	port( --Input signals
			a_byte_in: in std_logic_vector(9 downto 0);
			b_byte_in: in std_logic_vector(9 downto 0);
			c_byte_in: in std_logic_vector(9 downto 0);
			d_byte_in: in std_logic_vector(9 downto 0);
			cin: in std_logic;
			--Output signals
			val12bit_out: out std_logic_vector(11 downto 0)
	);
end component;

-- Signal declaration
-- 40 bit internal signal used to hold the sums of the four 4-byte adders
signal int: std_logic_vector(39 downto 0);

begin
              
		A1: four_byte_adder port map (data_i(127 downto 120), data_i(119 downto 112),
											   data_i(111 downto 104), data_i(103 downto 96),
											   '0', int(39 downto 30));
		A2: four_byte_adder port map (data_i(95 downto 88), data_i(87 downto 80),
											   data_i(79 downto 72), data_i(71 downto 64),
											   '0', int(29 downto 20));
		A3: four_byte_adder port map (data_i(63 downto 56), data_i(55 downto 48),
											   data_i(47 downto 40), data_i(39 downto 32),
											   '0', int(19 downto 10));
		A4: four_byte_adder port map (data_i(31 downto 24), data_i(23 downto 16),
											   data_i(15 downto 8), data_i(7 downto 0),
											   '0', int(9 downto 0));
		-- Final Adder
		FA: four_10bit_word_adder port map (int(39 downto 30), int(29 downto 20), 
														int(19 downto 10), int(9 downto 0), '0',
														sum_12bit_o);

end Behavioral;