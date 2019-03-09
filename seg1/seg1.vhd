library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity seg1 is
    port (clk: in std_logic;
        rst: in std_logic;
        dataout: out std_logic_vector(7 downto 0);
        en: out std_logic_vector(3 downto 0));
end seg1;

architecture arch of seg1 is
signal div_cnt: unsigned(24 downto 0);
signal dataout_xhdl1: std_logic_vector(7 downto 0);
signal data4, en_xhdl: std_logic_vector(3 downto 0);
signal cnt0, cnt1, cnt2, cnt3: unsigned(3 downto 0);
signal first_over, second_over, third_over, last_over: std_logic;
begin
    xsegments: work.segments port map (std_logic_vector(div_cnt(19 downto 18)), rst,
        std_logic_vector(cnt0),
        std_logic_vector(cnt1),
        std_logic_vector(cnt2),
        std_logic_vector(cnt3),
        dataout_xhdl1, en_xhdl);

    dataout <= dataout_xhdl1;
    en <= en_xhdl;

    process (clk, rst)
    begin
        if rst = '0' then
            div_cnt <= (others => '0');
        elsif (clk'event and clk='1') then
            div_cnt <= div_cnt + 1;
        end if;
    end process;

    process (div_cnt(24), rst, last_over)
    begin
        if rst='0' then
            cnt0 <= (others => '0');
            first_over <= '0';
        elsif (div_cnt(24)'event and div_cnt(24)='1') then
            if (cnt0 = "1001" or last_over = '1') then
                cnt0 <= "0000";
                first_over <= '1';
            else
                first_over <= '0';
                cnt0 <= cnt0 + 1;
            end if;
        end if;
    end process;

    process (first_over, rst)               --second 10  counter
    begin
        if rst='0' then
            cnt1 <= "0000";
            second_over <= '0';
        elsif (first_over'event and first_over='1')then
            if (cnt1 = "1001") then
                cnt1 <= "0000";
                second_over<='1';
            else
                second_over<='0';
                cnt1 <= cnt1 + 1;
            end if;
        end if;
    end process;

    process (second_over,rst) begin
        if (rst='0') then
            cnt2 <= "0000";
            third_over<='0';
        elsif (second_over'event and second_over='1') then
            if cnt2 = "1001" then
                cnt2 <= "0000";
                third_over<='1';
            else
                third_over<='0';
                cnt2 <= cnt2 + 1;
            end if;
        end if;
    end process;

    process (third_over,rst) begin
        if rst='0' then
            cnt3 <= "0000";
            last_over<='0';
        elsif (third_over'event and third_over='1') then
            if (cnt3 = "1001") then
                cnt3 <= "0000";
                last_over<='1';
            else
                last_over<='0';
                cnt3 <= cnt3 + 1;
            end if;
        end if;
    end process;
end arch;


