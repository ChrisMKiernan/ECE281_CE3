----------------------------------------------------------------------------------
-- Company: USAFA/DFEC
-- Engineer: Chris Kiernan
-- 
-- Create Date:    10:33:47 07/07/2012 
-- Design Name: 
-- Module Name:    MealyElevatorController - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MealyElevatorController_Shell is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           stop : in  STD_LOGIC;
           up_down : in  STD_LOGIC;
           floor : out  STD_LOGIC_VECTOR (3 downto 0);
			  nextfloor : out std_logic_vector (3 downto 0));
end MealyElevatorController_Shell;

architecture Behavioral of MealyElevatorController_Shell is

type floor_state_type is (floor1, floor2, floor3, floor4);

signal floor_state, nextfloor_signal : floor_state_type;

begin

---------------------------------------------------------
--Code your Mealy machine next-state process below
--Question: Will it be different from your Moore Machine?
---------------------------------------------------------
floor_state_machine: process(clk)
begin
--Insert your state machine below:
--I'm starting with the Moore machine and modifying it
--When we consider the design of a Mealy v Moore machine, the Mealy only has one (or possibly several) extra wire(s)
--This extra wire(s) refers to the outputs being reliant on the inputs, as opposed to only being reliant on the current state
--Below, then, should be the same as the Moore machine, because the only change should be to output logic
	if rising_edge(clk) then
		if reset='1' then
			floor_state <= floor1;
		else
			case floor_state is
			
				when floor1 =>
					if (up_down='1' and stop='0') then 
						floor_state <= floor2;
					else
						floor_state <= floor1;
					end if;
					
				when floor2 => 
					if (up_down='1' and stop='0') then 
						floor_state <= floor3; 			
					elsif (up_down='0' and stop='0') then 
						floor_state <= floor1;
					else
						floor_state <= floor2;
					end if;
					
				when floor3 =>
					if (up_down='1' and stop='0') then 
						floor_state <= floor4;
					elsif (up_down='0' and stop='0') then 
						floor_state <= floor2;	
					else
						floor_state <= floor3;	
					end if;
					
				when floor4 =>
					if (up_down='0' and stop='0') then 
						floor_state <= floor3;	
					else 
						floor_state <= floor4;	
					end if;
				
				when others =>
					floor_state <= floor1;
			end case;
		end if;
	end if;
end process;


-----------------------------------------------------------
--Code your Ouput Logic for your Mealy machine below
--Remember, now you have 2 outputs (floor and nextfloor)
-----------------------------------------------------------
--I'm going to have the change from the Moore to the Mealy machine be that if the reset button is pressed outside of a clock cycle, then it will immediately return to floor 1

nextfloor_signal <= floor1 when (reset = '1') else
					floor_state;
					
nextfloor <= "0001" when (floor_state = floor1) else
				"0010" when (floor_state = floor2) else
				"0011" when (floor_state = floor3) else
				"0100" when (floor_state = floor4) else
				"0001";
				
floor <= "0001" when (nextfloor_signal = floor1) else
			"0010" when (nextfloor_signal = floor2) else
			"0011" when (nextfloor_signal = floor3) else
			"0100" when (nextfloor_signal = floor4) else
			"0001";

end Behavioral;

