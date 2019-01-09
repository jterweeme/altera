library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity seg1 is
    port (clk: in std_logic;
        rst: in std_logic;
        dataout: out std_logic_vector(7 downto 0);
        en: out std_logic_vector(3 downto 0));
end seg1;

architecture arch of seg1 is
signal div_cnt: std_logic_vector(24 downto 0);
signal data4: std_logic_vector(3 downto 0);
signal dataout_xhdl1: std_logic_vector(7 downto 0);
signal en_xhdl: std_logic_vector(3 downto 0);
signal cntfirst: std_logic_vector(3 downto 0);
signal cntsecond: std_logic_vector(3 downto 0);
signal cntthird: std_logic_vector(3 downto 0);
signal cntlast: std_logic_vector(3 downto 0);
signal first_over: std_logic;
signal second_over: std_logic;
signal third_over: std_logic;
signal last_over: std_logic;

component segments is
    port (clk: in std_logic_vector(1 downto 0);
        rst: in std_logic;
		  cntfirst: std_logic_vector(3 downto 0);
        cntsecond: std_logic_vector(3 downto 0);
        cntthird: std_logic_vector(3 downto 0);
        cntlast: std_logic_vector(3 downto 0);
        dataout: out std_logic_vector(7 downto 0);
        en: out std_logic_vector(3 downto 0));
end component;

begin
	 xsegments: segments port map (div_cnt(19 downto 18), rst, cntfirst, cntsecond, cntthird, cntlast, dataout_xhdl1, en_xhdl);
    dataout <= dataout_xhdl1;
    en <= en_xhdl;

    process (clk, rst)
    begin
        if (rst = '0') then
            div_cnt <= "0000000000000000000000000";
        elsif (clk'event and clk='1') then
            div_cnt <= div_cnt + 1;
        end if;
    end process;

    process (div_cnt(24), rst, last_over)
    begin
        if (rst = '0') then
            cntfirst <= "0000";
            first_over <= '0';
        elsif (div_cnt(24)'event and div_cnt(24)='1') then
            if (cntfirst = "1001" or last_over = '1') then
                cntfirst <= "0000";
                first_over <= '1';
            else
                first_over <= '0';
                cntfirst <= cntfirst + 1;
            end if;
        end if;
    end process;

    process(first_over,rst)               --second 10  counter
    begin
        if (rst='0') then
            cntsecond<="0000";
            second_over<='0';
        elsif (first_over'event and first_over='1')then
            if(cntsecond="1001")then
                cntsecond<="0000";
                second_over<='1';
            else
                second_over<='0';
                cntsecond<=cntsecond+1;
            end if;
        end if;
    end process;

    process(second_over,rst) begin
        if (rst='0') then
            cntthird<="0000";
            third_over<='0';
        elsif (second_over'event and second_over='1') then
            if (cntthird="1001") then
                cntthird<="0000";
                third_over<='1';
            else
                third_over<='0';
                cntthird<= cntthird+1;
            end if;
        end if;
    end process;

    process(third_over,rst) begin
        if (rst='0') then
            cntlast<="0000";
            last_over<='0';
        elsif (third_over'event and third_over='1') then
            if (cntlast = "1001") then
                cntlast<="0000";
                last_over<='1';
            else
                last_over<='0';
                cntlast<= cntlast+1;
            end if;
        end if;
    end process;
end arch;


