-- High 1-2ms 5-10% high
-- Period 20ms = 50Hz

library ieee;
use ieee.std_logic_1164.all;

entity PWM is
	port(
		clk: in std_logic; -- System clock in 50MHz
		angle: in integer range 0 to 100; 
       	PWM: out std_logic
	);
end PWM;

architecture arch_PWM of PWM is
	signal s_angle_converted: integer range 100000 to 200000;
	
	signal debug: integer;
	signal debugbinary: std_logic := '0';
begin
	
	s_angle_converted <= angle*1000+100000;

process(clk)
	variable period_counter: integer range 0 to 1000001 := 0;
	variable start_high_holder: std_logic := '0';
	variable high_holder: integer range 0 to 1000001 := 0;
begin
	if(rising_edge(clk)) then
		if(period_counter >= 1000000) then -- New "period" 50Hz (1000000)
			period_counter := 0;
			start_high_holder := '1';
		end if;

		if(start_high_holder = '1') then
			debugbinary <= not debugbinary;
			PWM <= '1';
			high_holder := high_holder+1;
	
			if(high_holder = s_angle_converted) then
				high_holder := 0;
				start_high_holder := '0';
				PWM <= '0';
			end if;			
		end if;

		period_counter := period_counter+1;
		debug <= period_counter;
	end if;
end process;

end arch_PWM;