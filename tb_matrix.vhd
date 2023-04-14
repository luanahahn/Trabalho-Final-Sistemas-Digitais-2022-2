--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:18:06 04/11/2023
-- Design Name:   
-- Module Name:   /home/ericp/sd/trab2mem/tb_matrix.vhd
-- Project Name:  trab2mem
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: matrix
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
 
ENTITY tb_matrix IS
END tb_matrix;
 
ARCHITECTURE behavior OF tb_matrix IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT matrix
    PORT(
         entA : IN  std_logic_vector(31 downto 0);
         entB : IN  std_logic_vector(31 downto 0);
         entC : IN  std_logic_vector(31 downto 0);
         entD : IN  std_logic_vector(31 downto 0);
         saidaMF11 : OUT  std_logic_vector(15 downto 0);
         saidaMF12 : OUT  std_logic_vector(15 downto 0);
         saidaMF21 : OUT  std_logic_vector(15 downto 0);
         saidaMF22 : OUT  std_logic_vector(15 downto 0);
			start : IN std_logic;
         rst : IN  std_logic;
         clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal entA : std_logic_vector(31 downto 0) := (others => '0');
   signal entB : std_logic_vector(31 downto 0) := (others => '0');
   signal entC : std_logic_vector(31 downto 0) := (others => '0');
   signal entD : std_logic_vector(31 downto 0) := (others => '0');
	signal start : std_logic := '0';
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal saidaMF11 : std_logic_vector(15 downto 0);
   signal saidaMF12 : std_logic_vector(15 downto 0);
   signal saidaMF21 : std_logic_vector(15 downto 0);
   signal saidaMF22 : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: matrix PORT MAP (
          entA => entA,
          entB => entB,
          entC => entC,
          entD => entD,
          saidaMF11 => saidaMF11,
          saidaMF12 => saidaMF12,
          saidaMF21 => saidaMF21,
          saidaMF22 => saidaMF22,
			 start => start,
          rst => rst,
          clk => clk
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
      wait for 100 ns;
		
		-- set inputs
		entA <= "01110111" & "00101010" & "00011110" & "01000000";  -- 119, 42; 30, 64;
		entB <= "00011000" & "00001010" & "01001000" & "00001101";  -- 24, 10; 72, 13;
		entC <= "01011011" & "00110111" & "00010010" & "01111001";  -- 91, 55; 18, 121;
		entD <= "01000100" & "00011100" & "00010101" & "01001010";  -- 68, 28; 21, 74;

      wait for clk_period*10;
		
		-- reset
		rst <= '1';
		wait for clk_period*3;
		rst <= '0';
		wait for clk_period*3;

      -- start
		start <= '1';
		wait for clk_period;
		start <= '0';

      wait for clk_period*5;

      -- set inputs
		entA <= "00000110" & "00001010" & "00011110" & "00000001";  -- 6, 10; 30, 1;
		entB <= "00000101" & "00001010" & "00001000" & "00001101";  -- 5, 10; 8, 13;
		entC <= "10011011" & "00010111" & "00000010" & "00001001";  -- 115, 23; 2, 9;
		entD <= "00000100" & "00011100" & "00010101" & "00101010";  -- 4, 28; 21, 42;

      wait for clk_period*10;
		
		-- reset
		rst <= '1';
		wait for clk_period*3;
		rst <= '0';
		wait for clk_period*3;

      -- start
		start <= '1';
		wait for clk_period;
		start <= '0';

      wait for clk_period*5;

      -- set inputs
		entA <= "00000110" & "00001010" & "00000110" & "00000001";  -- 6, 10; 6, 1;
		entB <= "00000101" & "00001010" & "00001000" & "00001101";  -- 5, 10; 8, 13;
		entC <= "00000000" & "00000111" & "00000010" & "00001001";  -- 0, 7; 2, 9;
		entD <= "00000100" & "00001100" & "00010101" & "00001010";  -- 4, 12; 21, 10;

      wait for clk_period*10;
		
		-- reset
		rst <= '1';
		wait for clk_period*3;
		rst <= '0';
		wait for clk_period*3;

      -- start
		start <= '1';
		wait for clk_period;
		start <= '0';

      wait for clk_period*5;

      wait;
   end process;

END;
