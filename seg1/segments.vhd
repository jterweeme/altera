library ieee;
use ieee.std_logic_1164.all;

entity segments is
    port (clk: in std_logic_vector(1 downto 0);
        rst: in std_logic;
        cnt0, cnt1, cnt2, cnt3: in std_logic_vector(3 downto 0);
        dataout: out std_logic_vector(7 downto 0);
        en: out std_logic_vector(3 downto 0));
end segments;

architecture arch of segments is
signal data4: std_logic_vector(3 downto 0);
signal dataout_xhdl1: std_logic_vector(7 downto 0);
begin
    xsegment: work.segment port map (data4, dataout_xhdl1);
    dataout <= dataout_xhdl1;
	 
    process (clk, rst, cnt0, cnt1, cnt2, cnt3)
    begin
        if rst='0' then
            en <= "1110";
        else
            case clk is
            when "00" =>
                en <= "1110";
                data4 <= cnt0;
            when "01" =>
                en <= "1101";
                data4 <= cnt1;
            when "10" =>
                en <= "1011";
                data4 <= cnt2;
            when "11" =>
                en <= "0111";
                data4 <= cnt3;
            end case;
        end if;
    end process;
end arch;


