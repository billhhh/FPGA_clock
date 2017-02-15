LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY sel IS
	PORT
	(
		scan_clk		: IN	STD_LOGIC;
        LED_1, LED_2,LED_3: in STD_LOGIC_VECTOR(7 downto 0);
		LED		: out STD_LOGIC_VECTOR(7 downto 0);
		s		: out	STD_LOGIC_VECTOR(2 downto 0)
	);
END sel;

ARCHITECTURE a OF sel IS
BEGIN
PROCESS (scan_clk)
	VARIABLE n	: integer range 0 to 2;
BEGIN
IF rising_edge(scan_clk) THEN
   CASE n IS
	WHEN 0 => s<="011"; led<=LED_1; n:=n+1;
	WHEN 1 => s<="101"; LED<=LED_2; n:=n+1;
	WHEN 2 => s<="110"; LED<=LED_3; n:=0;
   END CASE;
    
END IF;
END PROCESS ;

END a;
