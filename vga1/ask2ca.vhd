
--640x480
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

	--Define The Core Entity
ENTITY ask2ca IS
PORT(   
		--Counter/VGA Timing
		clk		: IN STD_LOGIC;
		
		--VGA Signals/Pins (Outputs)
		hsync,
		vsync,
		red,
		green,
		blue : OUT STD_LOGIC);
		
		--Sync Counters
--		row,
--		column	: OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
end ask2ca;

	--Define The Architecture Of The Entity
architecture behavior of ask2ca is
signal clk25: STD_LOGIC;
signal h_sync, v_sync: STD_LOGIC;
signal video_en, horizontal_en, vertical_en: STD_LOGIC;
signal red_signal, green_signal, blue_signal: STD_LOGIC;
signal h_cnt, v_cnt: STD_LOGIC_VECTOR(9 DOWNTO 0);
begin
	video_en <= horizontal_en AND vertical_en;

--Generate 25Mhz Clock
process (clk)
begin
	if clk'event and clk='1' then
	  if (clk25 = '0')then
	    clk25 <= '1' after 2 ns;
	  else
	    clk25 <= '0' after 2 ns;
		end if;
	end if;
end process;	

PROCESS
--variable cnt: integer range 0 to 25175000;
variable cnt: integer range 0 to 25000000;

BEGIN

	--WAIT UNTIL(clk'EVENT) AND (clk = '1');
	WAIT UNTIL(clk25'EVENT) AND (clk25 = '1');
	
	--IF(cnt = 25175000)THEN	
	IF(cnt = 25000000)THEN	
	
	cnt := 0;
	ELSE
	cnt := cnt  + 1;
	END IF;
	
	--Horizontal Sync
	
		--Reset Horizontal Counter
	IF (h_cnt = 799) THEN
		h_cnt <= "0000000000";
	ELSE
		h_cnt <= h_cnt + 1;
	END IF;

		--Generate Horizontal Data
				--160 Rows Of Red
	IF (v_cnt >= 0) AND (v_cnt <= 159) THEN
		red_signal <= '1';
		green_signal <= '0';
		blue_signal <= '0';
	END IF;	
				--160 Rows Of Green
	IF (v_cnt >= 160) AND (v_cnt <= 319) THEN
		red_signal <= '0';
		green_signal <= '1';
		blue_signal <= '0';
	END IF;	
				--160 Rows Of Blue
	IF (v_cnt >= 320) AND (v_cnt <= 479) THEN
		red_signal <= '0';
		green_signal <= '0';
		blue_signal <= '1';		
	END IF;
	
	
	
		--Generate Horizontal Sync
	IF (h_cnt <= 755) AND (h_cnt >= 659) THEN
		h_sync <= '0';
	ELSE
		h_sync <= '1';
	END IF;
	
	--Vertical Sync

		--Reset Vertical Counter
	IF (v_cnt >= 524) AND (h_cnt >= 699) THEN
		v_cnt <= "0000000000";
	ELSIF (h_cnt = 699) THEN
		v_cnt <= v_cnt + 1;
	END IF;
	
		--Generate Vertical Sync
	IF (v_cnt <= 494) AND (v_cnt >= 493) THEN
		v_sync <= '0';	
		
	ELSE
		v_sync <= '1';
	END IF;
	
    IF (h_cnt <= 639) THEN
        horizontal_en <= '1';
    ELSE
        horizontal_en <= '0';
    END IF;
	
    IF (v_cnt <= 479) THEN
        vertical_en <= '1';
    ELSE
        vertical_en <= '0';
    END IF;
	
    red <= red_signal and video_en;
    green <= green_signal and video_en;
    blue <= blue_signal and video_en;
    hsync <= h_sync;
    vsync <= v_sync;
end process;
end behavior;



