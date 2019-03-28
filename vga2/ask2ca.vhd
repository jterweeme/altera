
--rood, groen, blauw: resolutie 640x480
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ask2ca is
    port(
        clk: in std_logic;
        hsync, vsync, red, green, blue: out std_logic);
end ask2ca;

architecture behavior of ask2ca is
signal clk25, v_sync: std_logic;
signal h_cnt, v_cnt: unsigned(9 downto 0);
begin
    clockdiv: process (clk)
    begin
        if clk'event and clk='1' then
            if (clk25 = '0')then
                clk25 <= '1' after 2 ns;
            else
                clk25 <= '0' after 2 ns;
            end if;
        end if;
    end process;

    red <= '1' when v_cnt >= 0 and v_cnt <= 319 else '0';
    green <= '1' when v_cnt >= 160 and v_cnt <= 319 else '0';
    blue <= '1' when v_cnt >= 160 and v_cnt <= 479 else '0';
    hsync <= '0' when h_cnt <= 755 and h_cnt >= 659 else '1';
    vsync <= '0' when v_cnt <= 494 and v_cnt >= 493 else '1';

    process (clk25)
    begin
        if rising_edge(clk25) then
            if h_cnt = 799 then
            h_cnt <= "0000000000";
            else
            h_cnt <= h_cnt + 1;
            end if;

            if v_cnt >= 524 and h_cnt >= 699 then
            v_cnt <= "0000000000";
            elsif h_cnt = 699 then
            v_cnt <= v_cnt + 1;
            end if;
        end if;
    end process;
end behavior;



