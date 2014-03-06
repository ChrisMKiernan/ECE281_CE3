--------------------------------------------------------------------------------
-- Company: USAFA
-- Engineer: Chris Kiernan
--
-- Create Date:   14:12:22 03/05/2014
-- Design Name:   CE3 - Elevator Controller
-- Module Name:   C:/Users/C16Christopher.Kiern/Documents/ECE 281/CEs/CE3/CE3_Kiernan/Moore_testbench_Kiernan.vhd
-- Project Name:  CE3_Kiernan
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MooreElevatorController_Shell
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
 
ENTITY Moore_testbench_Kiernan IS
END Moore_testbench_Kiernan;
 
ARCHITECTURE behavior OF Moore_testbench_Kiernan IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MooreElevatorController_Shell
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         stop : IN  std_logic;
         up_down : IN  std_logic;
         floor : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal stop : std_logic := '0';
   signal up_down : std_logic := '0';

 	--Outputs
   signal floor : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MooreElevatorController_Shell PORT MAP (
          clk => clk,
          reset => reset,
          stop => stop,
          up_down => up_down,
          floor => floor
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
      -- hold reset state for 100 ns.
		--reset state, on floor 1
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
		wait for clk_period*10;
		
      

      -- insert stimulus here 

      wait;
   end process;

END;
