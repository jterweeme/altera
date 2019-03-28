--
-- Z80 compatible microprocessor core, synchronous top level
-- Different timing than the original z80
-- Inputs needs to be synchronous and outputs may glitch
--
-- Version : 0242
--
-- Copyright (c) 2001-2002 Daniel Wallner (jesus@opencores.org)
--
-- All rights reserved
--
-- Redistribution and use in source and synthezised forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- Redistributions of source code must retain the above copyright notice,
-- this list of conditions and the following disclaimer.
--
-- Redistributions in synthesized form must reproduce the above copyright
-- notice, this list of conditions and the following disclaimer in the
-- documentation and/or other materials provided with the distribution.
--
-- Neither the name of the author nor the names of other contributors may
-- be used to endorse or promote products derived from this software without
-- specific prior written permission.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
-- THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
-- PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.
--
-- Please report bugs to the author, but before you do so, please
-- make sure that this is not a derivative work and that
-- you have the latest version of this file.
--
-- The latest version of this file can be found at:
--	http://www.opencores.org/cvsweb.shtml/t80/
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity T80s is
port(
    reset_n: in std_logic;
    clk_n: in std_logic;
    m1_n: out std_logic;
    mreq_n: out std_logic;
    iorq_n: out std_logic;
    RD_n: out std_logic;
    WR_n: out std_logic;
    RFSH_n: out std_logic;
    HALT_n: out std_logic;
    BUSAK_n: out std_logic;
    A: out std_logic_vector(15 downto 0);
    DI: in std_logic_vector(7 downto 0);
    DO: out std_logic_vector(7 downto 0)
);
end T80s;

architecture rtl of T80s is
signal IntCycle_n, NoRead, Write, IORQ: std_logic;
signal DI_Reg: std_logic_vector(7 downto 0);
signal MCycle: std_logic_vector(2 downto 0);
signal TState: std_logic_vector(2 downto 0);
begin
    u0: entity work.T80 port map(
        reset_n,
        clk_n,
        M1_n => M1_n,
        IORQ => IORQ,
        NoRead => NoRead,
        Write => Write,
        RFSH_n => RFSH_n,
        HALT_n => HALT_n,
        --WAIT_n => '1',
        INT_n => '1',
        NMI_n => '1',
        BUSRQ_n => '1',
        BUSAK_n => BUSAK_n,
        A => A,
        DInst => DI,
        DI => DI_Reg,
        DO => DO,
        MC => MCycle,
        TS => TState,
        IntCycle_n => IntCycle_n);

    process (RESET_n, CLK_n)
    begin
        if RESET_n = '0' then
            RD_n <= '1';
            WR_n <= '1';
            IORQ_n <= '1';
            MREQ_n <= '1';
            DI_Reg <= "00000000";
        elsif CLK_n'event and CLK_n = '1' then
			RD_n <= '1';
			WR_n <= '1';
			IORQ_n <= '1';
			MREQ_n <= '1';
			if MCycle = "001" then
				if TState = "001" then
					RD_n <= not IntCycle_n;
					MREQ_n <= not IntCycle_n;
					IORQ_n <= IntCycle_n;
				end if;
				if TState = "011" then
					MREQ_n <= '0';
				end if;
			else
				if TState = "001" and NoRead = '0' and Write = '0' then
					RD_n <= '0';
					IORQ_n <= not IORQ;
					MREQ_n <= IORQ;
				end if;
				if TState = "001" and Write = '1' then
					WR_n <= '0';
					IORQ_n <= not IORQ;
					MREQ_n <= IORQ;
				end if;
			end if;
            if TState = "010" then
                DI_Reg <= DI;
            end if;
        end if;
    end process;
end;


