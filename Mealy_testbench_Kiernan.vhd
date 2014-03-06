--------------------------------------------------------------------------------
-- Company: USAFA
-- Engineer:	Chris Kiernan
--
-- Create Date:   12:58:08 03/06/2014
-- Design Name:   
-- Module Name:   C:/Users/C16Christopher.Kiern/Documents/ECE 281/CEs/CE3/CE3_Kiernan/Mealy_testbench_Kiernan.vhd
-- Project Name:  CE3_Kiernan
-- Target Device:  
-- Tool versions:  
-- Description:   Testbench for the Mealy Machine
-- 
-- VHDL Test Bench Created by ISE for module: MealyElevatorController_Shell
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Mealy_testbench_Kiernan IS
END Mealy_testbench_Kiernan;
 
ARCHITECTURE behavior OF Mealy_testbench_Kiernan IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MealyElevatorController_Shell
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         stop : IN  std_logic;
         up_down : IN  std_logic;
         floor : OUT  std_logic_vector(3 downto 0);
         nextfloor : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal stop : std_logic := '0';
   signal up_down : std_logic := '0';

 	--Outputs
   signal floor : std_logic_vector(3 downto 0);
   signal nextfloor : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MealyElevatorController_Shell PORT MAP (
          clk => clk,
          reset => reset,
          stop => stop,
          up_down => up_down,
          floor => floor,
          nextfloor => nextfloor
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
	--Here I'll make a testbench that runs the same as the Moore testbench to test the functionality of that, then I will make another that is similar but with the reset button held to test that functionality
      -- hold reset state for 100 ns.
      wait for 100 ns;	

		reset <= '1';
		up_down <= '0';
		stop <= '0';
      wait for 100 ns;	
		
		--moving to floor 2, only use one clock cycle
		reset <= '0';
		up_down <= '1';
		stop <= '0';
		wait for clk_period*1;
		
		--stop for 2 clock cycles on floor 2
		reset <= '0';
		up_down <= '1';
		stop <= '1';
		wait for clk_period*2;
		
		--move to floor 3, only one clk
		reset <= '0';
		up_down <= '1';
		stop <= '0';
		wait for clk_period*1;
		
		--stop for 2 clk cycles on fl3
		reset <= '0';
		up_down <= '1';
		stop <= '1';
		wait for clk_period*2;
		
		--move to floor 4
		reset <= '0';
		up_down <= '1';
		stop <= '0';
		wait for clk_period*1;
		
		--wait on floor 4 for 2 clk cycles
		reset <= '0';
		up_down <= '1';
		stop <= '1';
		wait for clk_period*2;
		
		reset <= '0';
		up_down <= '0';
		stop <= '0';
		wait for clk_period*5;
	--This is the end of the original test, now I will recreate with the reset button pressed in the middle of a clock cycle
	
		
		--trying to move to floor 2, only use one clock cycle
		reset <= '0';
		up_down <= '1';
		stop <= '0';
		wait for clk_period*1;
		
		--stop for 2 clock cycles on floor 2
		reset <= '0';
		up_down <= '1';
		stop <= '1';
		wait for clk_period*2;
		
		-- try to move to floor 3, only one clk
		reset <= '0';
		up_down <= '1';
		stop <= '0';
		wait for 2 ns;
		
	-- 2 ns is not during a clock cycle, I'm hoping to bypass the clock on my Mealy Machine

		reset <= '1';
		up_down <= '1';
		stop <= '0';
		wait for 8 ns;
		--the 8 at the end should bring the cycle back
		
		--hold for a while on floor 1
		reset <= '1';
		up_down <= '1';
		stop <= '1';
		wait for clk_period*2;
		
		--move up again to test
		reset <= '0';
		up_down <= '1';
		stop <= '0';
		wait for clk_period*1;
		
		--wait on floor 2 for 2 clk cycles
		reset <= '0';
		up_down <= '1';
		stop <= '1';
		wait for clk_period*2;
		
		reset <= '0';
		up_down <= '0';
		stop <= '0';
		wait for clk_period*10;
		--back down

      -- insert stimulus here 

      wait;
   end process;

END;
