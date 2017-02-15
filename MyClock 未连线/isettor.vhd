library ieee;
use ieee.std_logic_1164.all;

ENTITY isettor IS
	PORT
	(
	    IS_SET :  in STD_LOGIC_VECTOR(1 DOWNTO 0);			--设置状态选择端
		RESET  :  in Std_Logic;								--复位端
		BCDshi :  in STD_LOGIC_VECTOR(3 DOWNTO 0);
		BCDge  :  in STD_LOGIC_VECTOR(3 DOWNTO 0);			--输入 BCD码的 十位 和 个位
		
		SEC_EN :  out integer range 0 to 100;				--秒      的使能端
		MIN_EN :  out integer range 0 to 100;				--分      的使能端
		HOUR_EN :  out integer range 0 to 100				--小时    的使能端
		
	);
END;


ARCHITECTURE a OF isettor IS
	signal tod_shi : integer range 0 to 60;					--BCD	转换成十进制  的十位
	signal tod_ge  : integer range 0 to 9;					--BCD	转换成十进制  的个位
BEGIN

--对于BCD码 向 十进制的转换
WITH  BCDshi  SELECT
tod_shi  	<=  
0	WHEN "0000",
10	WHEN "0001",
20	WHEN "0010",
30	WHEN "0011",
40	WHEN "0100",
50	WHEN "0101",
60	WHEN "0110",
0 	WHEN OTHERS;

WITH  BCDge  SELECT
tod_ge  	<=  
0	WHEN "0000",
1	WHEN "0001",
2	WHEN "0010",
3	WHEN "0011",
4	WHEN "0100",
5	WHEN "0101",
6	WHEN "0110",
7	WHEN "0111",
8	WHEN "1000",
9	WHEN "1001",
0 	WHEN OTHERS;




PROCESS (reset,is_set)
	variable sum :  integer range 0 to 60;
BEGIN
	  sum:=tod_shi+tod_ge;
		
	  if(reset='1')  then
	 	 SEC_EN<=0;  MIN_EN<=0;  HOUR_EN<=0;
	
	  else
		CASE is_set IS
			WHEN "00" => SEC_EN<=80;  MIN_EN<=80;  HOUR_EN<=80;   --时、分、秒 均正常工作
			WHEN "01" => SEC_EN<=sum;  MIN_EN<=100;  HOUR_EN<=100;	--设置秒
			WHEN "10" => SEC_EN<=100;  MIN_EN<=sum;  HOUR_EN<=100;	--设置分
			WHEN "11" => SEC_EN<=100;  MIN_EN<=100;  HOUR_EN<=sum;	--设置小时
		END CASE;
		 
	
	  end if;	  
END PROCESS;



	
END a;
