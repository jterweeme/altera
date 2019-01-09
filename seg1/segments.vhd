library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity segments is
    port (clk: in std_logic_vector(1 downto 0);
        rst: in std_logic;
		  cntfirst: std_logic_vector(3 downto 0);
        cntsecond: std_logic_vector(3 downto 0);
        cntthird: std_logic_vector(3 downto 0);
        cntlast: std_logic_vector(3 downto 0);
        dataout: out std_logic_vector(7 downto 0);
        en: out std_logic_vector(3 downto 0));
end segments;

architecture arch of segments is
signal en_xhdl: std_logic_vector(3 downto 0);
begin
    process(rst,clk)
    begin
        if (rst='0') then
            en_xhdl<="1110";
        else
            case clk is
            when"00"=> en_xhdl<="1110";
            when"01"=> en_xhdl<="1101";
            when"10"=> en_xhdl<="1011";
            when"11"=> en_xhdl<="0111"; 
            end case;
        end if;
    end process;

end arch;


