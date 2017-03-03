library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
 
entity x6bit_counter is
  port (	clk:		in  std_logic;                      -- Input clock
			enable:	in  std_logic;                    -- Enable counting
			reset:	in  std_logic;                     -- Input reset
			load:		in  std_logic;                    -- Parallel load enable
			l:			in  std_logic_vector (5 downto 0);  -- Parallel load for the counter
			q: 		out std_logic_vector (5 downto 0)  -- Output of the counter  
		  );
end x6bit_counter;

architecture Behavioral of x6bit_counter is
    signal count :std_logic_vector (5 downto 0);
begin
    process (clk, reset) begin
        if (reset = '1') then
            count <= (others=>'0');
        elsif (rising_edge(clk)) then
            if (load = '1') then
                count <= l;
            elsif (enable = '1') then
                count <= count + 1;
            elsif (enable = '0') then
                count <= count;
            end if;
        end if;
    end process;
    q <= count;
end architecture;