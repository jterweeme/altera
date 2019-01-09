library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity segment is
    port (data4: in std_logic_vector(3 downto 0);
        dataout: out std_logic_vector(7 downto 0));
end segment;

architecture arch of segment is
signal dataout_xhdl1: std_logic_vector(7 downto 0);
begin
    dataout <= dataout_xhdl1;

    process(data4) begin
        case data4 is
        when "0000" => dataout_xhdl1 <= "11000000";    
        when "0001" => dataout_xhdl1 <= "11111001";    
        when "0010" => dataout_xhdl1 <= "10100100";    
        when "0011" => dataout_xhdl1 <= "10110000";    
        when "0100" => dataout_xhdl1 <= "10011001";    
        when "0101" => dataout_xhdl1 <= "10010010";    
        when "0110" => dataout_xhdl1 <= "10000010";    
        when "0111" => dataout_xhdl1 <= "11111000";    
        when "1000" => dataout_xhdl1 <= "10000000";    
        when "1001" => dataout_xhdl1 <= "10010000";    
        when "1010" => dataout_xhdl1 <= "10000000";    
        when "1011" => dataout_xhdl1 <= "10010000";    
        when "1100" => dataout_xhdl1 <= "01100011";    
        when "1101" => dataout_xhdl1 <= "10000101";    
        when "1110" => dataout_xhdl1 <= "01100001";    
        when "1111" => dataout_xhdl1 <= "01110001";    
        when others => dataout_xhdl1 <= "00000011"; 
        end case;
    end process;
end arch;


