--rood, groen, blauw: resolutie 640x480@60Hz
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity de2_115 is
    port(
        clk: in std_logic;
        hsync, vsync, vga_clk: out std_logic;
        r, g, b: out std_logic_vector(7 downto 0));
end;

architecture behavior of de2_115 is
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

    r <= "11111111" when v_cnt >= 0 and v_cnt <= 159 else "00000000";
    g <= "11111111" when v_cnt >= 160 and v_cnt <= 319 else "00000000";
    b <= "11111111" when v_cnt >= 320 and v_cnt <= 479 else "00000000";
    hsync <= '0' when h_cnt <= 755 and h_cnt >= 659 else '1';
    vsync <= '0' when v_cnt <= 494 and v_cnt >= 493 else '1';
    vga_clk <= clk25;

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



