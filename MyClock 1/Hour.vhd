library ieee;
use IEEE.Std_Logic_1164.ALL;

ENTITY Hour IS
	PORT
	(
		clk  : IN Std_Logic; 
        clk_jin	 :  OUT Std_Logic;
		shi   :out  integer range 0 to 9;
		ge   :out  integer range 0 to 9
	);
END;

 ARCHITECTURE a OF Hour IS
	signal tmpout : integer range 0 to 60;
 BEGIN 


      PROCESS (CLK)
		VARIABLE count : integer range 0 to 24;
	  BEGIN
	  IF (rising_edge(clk)) THEN
		 count:=count+1;
		if(count>=24) then 
			clk_jin<='1';
			count:=0;
		else
			clk_jin<='0';
		end if;
	  END IF;
	
	 tmpout <= count;
 	 END PROCESS;


shi <= 	9 WHEN	tmpout>89	ELSE
		8 WHEN	tmpout>79	ELSE
		7 WHEN	tmpout>69	ELSE
		6 WHEN	tmpout>59	ELSE
		5 WHEN	tmpout>49	ELSE
		4 WHEN	tmpout>39	ELSE
		3 WHEN	tmpout>29	ELSE
		2 WHEN	tmpout>19	ELSE
		1 WHEN	tmpout>9	ELSE
		0 ;

ge<= tmpout-90 WHEN	tmpout>89	ELSE
	 tmpout-80 WHEN	tmpout>79	ELSE
	 tmpout-70 WHEN	tmpout>69	ELSE
     tmpout-60 WHEN	tmpout>59	ELSE
	 tmpout-50 WHEN	tmpout>49	ELSE
	 tmpout-40 WHEN	tmpout>39	ELSE
	 tmpout-30 WHEN	tmpout>29	ELSE
	 tmpout-20 WHEN	tmpout>19	ELSE
	 tmpout-10 WHEN	tmpout>9	ELSE
	 tmpout ;		


	


  END a; 