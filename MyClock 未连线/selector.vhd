LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY selector IS
	PORT
	(
		scan_clk		: IN	STD_LOGIC;
		
        sec_shi, sec_ge    : in  integer range 0 to 9;
		min_shi, min_ge    : in  integer range 0 to 9;
		hour_shi, hour_ge    : in  integer range 0 to 9;
		
		LED		: out STD_LOGIC_VECTOR(7 downto 0);
		sel		: out	STD_LOGIC_VECTOR(7 downto 0)
	);
END;



ARCHITECTURE a OF selector IS
	signal num : integer range 0 to 10;
BEGIN



PROCESS (scan_clk)
	VARIABLE n	: integer range 0 to 7;
BEGIN
IF rising_edge(scan_clk) THEN
   CASE n IS
	WHEN 0 => sel<="01111111";n:=n+1; num<=hour_shi;
	WHEN 1 => sel<="10111111";n:=n+1; num<=hour_ge;
	
	WHEN 2 => sel<="11011111";n:=n+1; num<=10;
	
	WHEN 3 => sel<="11101111";n:=n+1; num<=min_shi;
	WHEN 4 => sel<="11110111";n:=n+1; num<=min_ge;
	
	WHEN 5 => sel<="11111011";n:=n+1; num<=10;
	
	WHEN 6 => sel<="11111101";n:=n+1; num<=sec_shi;
	WHEN 7 => sel<="11111110";n:=0;   num<=sec_ge;
   END CASE;
    
END IF;
END PROCESS ;



WITH  num  SELECT
LED  	<=  "00111111"	WHEN 0,
"00000110"	WHEN 1,
"01011011"	WHEN 2,
"01001111"	WHEN 3,
"01100110"	WHEN 4,
"01101101"	WHEN 5,
"01111101"	WHEN 6,
"00000111"	WHEN 7,
"01111111"	WHEN 8,
"01101111"	WHEN 9,
"01000000"  WHEN 10,
"10000000" 	WHEN OTHERS;


END a;
