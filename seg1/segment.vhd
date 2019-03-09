library ieee;
use ieee.std_logic_1164.all;

entity segment is
    port (data4: in std_logic_vector(3 downto 0);
        q: out std_logic_vector(7 downto 0));
end segment;

architecture arch of segment is
begin
    with data4 select
        q <= "11000000" when "0000",
             "11111001" when "0001",
             "10100100" when "0010",
             "10110000" when "0011",
             "10011001" when "0100",
             "10010010" when "0101",
             "10000010" when "0110",
             "11111000" when "0111",
             "10000000" when "1000",
             "10010000" when "1001",
             "10000000" when "1010",
             "10010000" when "1011",
             "01100011" when "1100",
             "10000101" when "1101",
             "01100001" when "1110",
             "01110001" when "1111";
end arch;


