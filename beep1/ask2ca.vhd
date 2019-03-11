library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity ask2ca is
    port(CLK: IN STD_LOGIC;
        SPEAKER: OUT STD_LOGIC);
end entity;

architecture song of ask2ca is
signal DRIVER, ORIGIN: std_logic_vector(12 downto 0);
signal COUNTER: INTEGER RANGE 0 TO 140;
signal COUNTER1: INTEGER RANGE 0 TO 3;
signal COUNTER2: INTEGER RANGE 1 TO 10000000;
signal DIGIT: std_logic_vector(6 downto 0);
signal COUNT: std_logic_vector(1 downto 0); 
signal CARRIER, CLK_4MHZ, CLK_4HZ: std_logic;
begin
PROCESS(CLK) BEGIN
    IF CLK'EVENT AND CLK='1' THEN
        IF COUNTER1 = 1 THEN
            CLK_4MHZ <= '1';
            COUNTER1 <= 2;
        ELSIF COUNTER1 = 3 THEN
            CLK_4MHZ <= '0';
            COUNTER1 <= 0;
        ELSE
            COUNTER1 <= COUNTER1+1;
        END IF;
   
        IF COUNTER2 = 5000000 THEN
            CLK_4HZ <= '1';
            COUNTER2 <= 5000001;
        ELSIF COUNTER2 = 10000000 THEN
            CLK_4HZ <= '0';
            COUNTER2 <= 1;
        ELSE
            COUNTER2 <= COUNTER2 + 1;
        END IF;
    END IF;
END PROCESS;

PROCESS(CLK_4MHZ)
BEGIN
    IF CLK_4MHZ'EVENT AND CLK_4MHZ='1' THEN
        IF DRIVER="1111111111111" THEN
            CARRIER<='1';
            DRIVER<=ORIGIN;
        ELSE
            DRIVER<=DRIVER+1;
            CARRIER<='0';
        END IF;
    END IF;
END PROCESS;

PROCESS(CARRIER)
BEGIN
IF CARRIER'EVENT AND CARRIER='1' THEN
    COUNT<=COUNT+1;
    IF COUNT="00"THEN
        SPEAKER<='1';
    ELSE
        SPEAKER<='0';
    END IF;
END IF;
END PROCESS;

process(CLK_4HZ)
begin
    if CLK_4HZ'event and CLK_4HZ='1' then
        if COUNTER=140 then
            COUNTER<=0;
        else
            COUNTER<=COUNTER+1;
        end if;
    end if;

    case COUNTER is
    when 0  =>DIGIT<="0000011";
    when 1  =>DIGIT<="0000011";
    when 2  =>DIGIT<="0000011";
    when 3  =>DIGIT<="0000011";
    when 4  =>DIGIT<="0000101";
    when 5  =>DIGIT<="0000101";
    when 6  =>DIGIT<="0000101";
    when 7  =>DIGIT<="0000110";
    when 8  =>DIGIT<="0001000";
    when 9  =>DIGIT<="0001000";
    when 10 =>DIGIT<="0001000";
    when 11 =>DIGIT<="0010000";
    when 12 =>DIGIT<="0000110";
    when 13 =>DIGIT<="0001000";
    when 14 =>DIGIT<="0000101";
    when 15 =>DIGIT<="0000101";
    when 16 =>DIGIT<="0101000";
    when 17 =>DIGIT<="0101000";
    when 18 =>DIGIT<="0101000";
    when 19 =>DIGIT<="1000000";
    when 20 =>DIGIT<="0110000";
    when 21 =>DIGIT<="0101000";
    when 22 =>DIGIT<="0011000";
    when 23 =>DIGIT<="0101000";
    when 24 =>DIGIT<="0010000";
    when 25 =>DIGIT<="0010000";
    when 26 =>DIGIT<="0010000";
    when 27 =>DIGIT<="0010000";
    when 28 =>DIGIT<="0010000";
    when 29 =>DIGIT<="0010000";
    when 30 =>DIGIT<="0000011";
    when 31 =>DIGIT<="0000000";
    when 32 =>DIGIT<="0010000";
    when 33 =>DIGIT<="0010000";
    when 34 =>DIGIT<="0010000";
    when 35 =>DIGIT<="0011000";
    when 36 =>DIGIT<="0000111";
    when 37 =>DIGIT<="0000111";
    when 38 =>DIGIT<="0000110";
    when 39 =>DIGIT<="0000110";
    when 40 =>DIGIT<="0000101";
    when 41 =>DIGIT<="0000101";
    when 42 =>DIGIT<="0000101";
    when 43 =>DIGIT<="0000110";
    when 44 =>DIGIT<="0001000";
    when 45 =>DIGIT<="0001000";
    when 46 =>DIGIT<="0010000";
    when 47 =>DIGIT<="0010000";
    when 48 =>DIGIT<="0000011";
    when 49 =>DIGIT<="0000011";
    when 50 =>DIGIT<="0001000";
    when 51 =>DIGIT<="0001000";
    when 52 =>DIGIT<="0000110";
    when 53 =>DIGIT<="0000101";
    when 54 =>DIGIT<="0000110";
    when 55 =>DIGIT<="0001000";
    when 56 =>DIGIT<="0000101";
    when 57 =>DIGIT<="0000101";
    when 58 =>DIGIT<="0000101";
    when 59 =>DIGIT<="0000101";
    when 60 =>DIGIT<="0000101";
    when 61 =>DIGIT<="0000101";
    when 62 =>DIGIT<="0000101";
    when 63 =>DIGIT<="0000101";
    when 64 =>DIGIT<="0011000";
    when 65 =>DIGIT<="0011000";
    when 66 =>DIGIT<="0011000";
    when 67 =>DIGIT<="0101000";
    when 68 =>DIGIT<="0000111";
    when 69 =>DIGIT<="0000111";
    when 70 =>DIGIT<="0010000";
    when 71 =>DIGIT<="0010000";
    when 72 =>DIGIT<="0000110";
    when 73 =>DIGIT<="0001000";
    when 74 =>DIGIT<="0000101";
    when 75 =>DIGIT<="0000101";
    when 76 =>DIGIT<="0000101";
    when 77 =>DIGIT<="0000101";
    when 78 =>DIGIT<="0000101";
    when 79 =>DIGIT<="0000101";
    when 80 =>DIGIT<="0000011";
    when 81 =>DIGIT<="0000101";
    when 82 =>DIGIT<="0000011";
    when 83 =>DIGIT<="0000011";
    when 84 =>DIGIT<="0000101";
    when 85 =>DIGIT<="0000110";
    when 86 =>DIGIT<="0000111";
    when 87 =>DIGIT<="0010000";
    when 88 =>DIGIT<="0000110";
    when 89 =>DIGIT<="0000110";
    when 90 =>DIGIT<="0000110";
    when 91 =>DIGIT<="0000110";
    when 92 =>DIGIT<="0000110";
    when 93 =>DIGIT<="0000110";
    when 94 =>DIGIT<="0000101";
    when 95 =>DIGIT<="0000110";
    when 96 =>DIGIT<="0001000";
    when 97 =>DIGIT<="0001000";
    when 98 =>DIGIT<="0001000";
    when 99 =>DIGIT<="0010000";
    when 100=>DIGIT<="0101000";
    when 101=>DIGIT<="0101000";
    when 102=>DIGIT<="0101000";
    when 103=>DIGIT<="0011000";
    when 104=>DIGIT<="0010000";
    when 105=>DIGIT<="0010000";
    when 106=>DIGIT<="0011000";
    when 107=>DIGIT<="0010000";
    when 108=>DIGIT<="0001000";
    when 109=>DIGIT<="0001000";
    when 110=>DIGIT<="0000110";
    when 111=>DIGIT<="0000101";
    when 112=>DIGIT<="0000011";
    when 113=>DIGIT<="0000011";
    when 114=>DIGIT<="0000011";
    when 115=>DIGIT<="0000011";
    when 116=>DIGIT<="0001000";
    when 117=>DIGIT<="0001000";
    when 118=>DIGIT<="0000110";
    when 119=>DIGIT<="0001000";
    when 120=>DIGIT<="0000110";
    when 121=>DIGIT<="0000011";
    when 122=>DIGIT<="0000011";
    when 123=>DIGIT<="0010000";
    when 124=>DIGIT<="0000011";
    when 125=>DIGIT<="0000101";
    when 126=>DIGIT<="0000110";
    when 127=>DIGIT<="0001000";
    when 128=>DIGIT<="0000101";
    when 129=>DIGIT<="0000101";
    when 130=>DIGIT<="0000101";
    when 131=>DIGIT<="0000101";
    when 132=>DIGIT<="0000101";
    when 133=>DIGIT<="0000101";
    when 134=>DIGIT<="0000101";
    when 135=>DIGIT<="0000101";
    when 136=>DIGIT<="0000000";
    when 137=>DIGIT<="0000000";
    when 138=>DIGIT<="0000000";
    when 139=>DIGIT<="0000000";
    when others => DIGIT <= "0000000";
    end case;

    case DIGIT is
    when "0000011" => ORIGIN<="0100001001100";
    when "0000101" => ORIGIN<="0110000010001";
    when "0000110" => ORIGIN<="0111000111110";
    when "0000111" => ORIGIN<="1000000101101";
    when "0001000" => ORIGIN<="1000100010001";
    when "0010000" => ORIGIN<="1001010110010";
    when "0011000" => ORIGIN<="1010000100101";
    when "0101000" => ORIGIN<="1011000001000";
    when "0110000" => ORIGIN<="1011100011110";
    when "1000000" => ORIGIN<="1100010001000";
    when others => ORIGIN<="1111111111111";
    end case;
end process;
end song;




