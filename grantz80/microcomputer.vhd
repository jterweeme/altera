library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity microcomputer is
    port(
        n_reset, clk, rxd1: in std_logic;
        txd1: out std_logic;
        leds: out std_logic_vector(7 downto 0)
    );
end microcomputer;

architecture struct of microcomputer is
signal n_WR, n_RD, cpuClock, uart_clk: std_logic;
signal cpu_a: std_logic_vector(15 downto 0);
signal cpu_out, cpu_in, basRomData, ram_out: std_logic_vector(7 downto 0);
signal interface1DataOut: std_logic_vector(7 downto 0);
signal n_memWR, n_memRD, n_ioWR, n_ioRD, n_MREQ, n_IORQ, n_int1, n_int2: std_logic;
signal n_ram_cs, n_basRomCS, n_interface1CS, n_aaronCS: std_logic;
signal serialClkCount: unsigned(15 downto 0);
signal cpuClkCount: unsigned(5 downto 0); 
begin
    cpu1: entity work.t80s port map(n_reset, cpuClock,
            mreq_n => n_MREQ, iorq_n => n_IORQ, rd_n => n_RD, wr_n => n_WR,
            a => cpu_a, di => cpu_in, do => cpu_out);

    rom1: entity work.rom port map(cpu_a(12 downto 0), clk, basRomData);

    ram1: entity work.ram
        port map(cpu_a(11 downto 0), clk, cpu_out, not(n_memWR or n_ram_cs), ram_out);

    io1: entity work.bufferedUART port map(clk, n_interface1CS or n_ioWR,
        n_interface1CS or n_ioRD, cpu_a(0), cpu_out, interface1DataOut,
        n_int1, uart_clk, uart_clk, rxd1, txd1, n_cts => '0',
        n_dcd => '0');

    io2: entity work.aaron port map(n_aaronCS or n_ioWR, n_reset, cpu_out, leds);
    n_ioWR <= n_WR or n_IORQ;
    n_memWR <= n_WR or n_MREQ;
    n_ioRD <= n_RD or n_IORQ;
    n_memRD <= n_RD or n_MREQ;
    n_basRomCS <= '0' when cpu_a(15 downto 13) = "000" else '1'; --8K at bottom of memory
    n_ram_cs <= '0' when cpu_a(15 downto 12) = "0010" else '1';
    uart_clk <= serialClkCount(15);

    n_interface1CS <= '0' when cpu_a(7 downto 1) = "1000000" and
        (n_ioWR='0' or n_ioRD = '0') else '1'; -- 2 Bytes $80-$81

    n_aaronCS <= '0' when cpu_a(7 downto 1) = "1001000" and
        (n_ioWR='0' or n_ioRD = '0') else '1'; -- 2 Bytes $90-$91

    cpu_in <= interface1DataOut when n_interface1CS = '0' else
        basRomData when n_basRomCS = '0' else
        ram_out when n_ram_cs='0' else x"FF";

    process (clk)
    begin
        if rising_edge(clk) then
            if cpuClkCount < 4 then -- 4 = 10MHz, 3 = 12.5MHz, 2=16.6MHz, 1=25MHz
                cpuClkCount <= cpuClkCount + 1;
            else
                cpuClkCount <= (others=>'0');
            end if;
            if cpuClkCount < 2 then -- 2 when 10MHz, 2 when 12.5MHz, 2 when 16.6MHz, 1 when 25MHz
                cpuClock <= '0';
            else
                cpuClock <= '1';
            end if;

-- Serial clock DDS
-- 50MHz master input clock:
-- Baud Increment
-- 115200 2416
-- 38400 805
-- 19200 403
-- 9600 201
-- 4800 101
-- 2400 50
            serialClkCount <= serialClkCount + 2416;
        end if;
    end process;
end;



