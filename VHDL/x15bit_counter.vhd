library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
 
entity x11bit_counter is
  port (	clk:		in  std_logic;                     -- Input clock
			enable:	in  std_logic;                     -- Enable counting
			reset:	in  std_logic;                     -- Input reset   
			q: 		out std_logic_vector (10 downto 0) -- Output of the counter  
		  );
end x11bit_counter;

architecture Behavioral of x11bit_counter is
    signal count :std_logic_vector (10 downto 0);
begin
    process (clk, reset) begin
        if (reset = '1') then
            count <= (others=>'0');
        elsif (rising_edge(clk)) then
            if (enable = '1') then
                count <= count + 1;
				else
					 count <= count;
            end if;
        end if;
    end process;
    q <= count;
end architecture;