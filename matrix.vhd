----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:32:51 04/11/2023 
-- Design Name: 
-- Module Name:    matrix - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity matrix is
  Port(entA : in  STD_LOGIC_VECTOR (31 downto 0);
       entB : in  STD_LOGIC_VECTOR (31 downto 0);
       entC : in  STD_LOGIC_VECTOR (31 downto 0);
       entD : in  STD_LOGIC_VECTOR (31 downto 0);
       saidaMF11 : out  STD_LOGIC_VECTOR (15 downto 0);
       saidaMF12 : out  STD_LOGIC_VECTOR (15 downto 0);
       saidaMF21 : out  STD_LOGIC_VECTOR (15 downto 0);
       saidaMF22 : out  STD_LOGIC_VECTOR (15 downto 0);
       start : in std_logic;
       done : out std_logic;
       rst : in std_logic;
       clk : in std_logic
      );
end matrix;

architecture Behavioral of matrix is

-- estado
type t_estado is (s0, s1, s2, s3, s4, s5);
signal estado, prox_estado: t_estado;

-- Multiplicação e soma
signal MULT_AB: std_logic_vector(63 downto 0);
signal MULT_CD: std_logic_vector(63 downto 0);
signal SOMA_ABCD: std_logic_vector(63 downto 0);
signal FILTRA_MF: std_logic_vector(63 downto 0);

-- Registrador Matriz A
signal regA: std_logic_vector(31 downto 0);
signal loadA: std_logic;

-- Registrador Matriz B
signal regB: std_logic_vector(31 downto 0);
signal loadB: std_logic;

-- Registrador Matriz C
signal regC: std_logic_vector(31 downto 0);
signal loadC: std_logic;

-- Registrador Matriz D
signal regD: std_logic_vector(31 downto 0);
signal loadD: std_logic;

-- Registrador MR1
signal regMR1: std_logic_vector(63 downto 0);
signal loadMR1: std_logic;

-- Registrador MR2
signal regMR2: std_logic_vector(63 downto 0);
signal loadMR2: std_logic;

-- Registrador MP
signal regMP: std_logic_vector(63 downto 0);
signal loadMP: std_logic;

-- Registrador Matriz Final MF
signal regMF: std_logic_vector(63 downto 0);
signal loadMF: std_logic;

begin

-- Multiplicador A * B = MR1
process(regA, regB)
  variable a11, a12, a21, a22: std_logic_vector(7 downto 0);
  variable b11, b12, b21, b22: std_logic_vector(7 downto 0);

begin
  a11 := regA(31 downto 24);
  a12 := regA(23 downto 16);
  a21 := regA(15 downto 8);
  a22 := regA(7 downto 0);

  b11 := regB(31 downto 24);
  b12 := regB(23 downto 16);
  b21 := regB(15 downto 8);
  b22 := regB(7 downto 0);

  MULT_AB(63 downto 48) <= std_logic_vector(unsigned(a11) * unsigned(b11) + unsigned(a12) * unsigned(b21));
  MULT_AB(47 downto 32) <= std_logic_vector(unsigned(a11) * unsigned(b12) + unsigned(a12) * unsigned(b22));
  MULT_AB(31 downto 16) <= std_logic_vector(unsigned(a21) * unsigned(b11) + unsigned(a22) * unsigned(b21));
  MULT_AB(15 downto 0)  <= std_logic_vector(unsigned(a21) * unsigned(b12) + unsigned(a22) * unsigned(b22));
end process;

-- Multiplicador C * D = MR2
process(regC, regD)
  variable c11, c12, c21, c22: std_logic_vector(7 downto 0);
  variable d11, d12, d21, d22: std_logic_vector(7 downto 0);

begin
  c11 := regC(31 downto 24);
  c12 := regC(23 downto 16);
  c21 := regC(15 downto 8);
  c22 := regC(7 downto 0);

  d11 := regD(31 downto 24);
  d12 := regD(23 downto 16);
  d21 := regD(15 downto 8);
  d22 := regD(7 downto 0);

  MULT_CD(63 downto 48) <= std_logic_vector(unsigned(c11) * unsigned(d11) + unsigned(c12) * unsigned(d21));
  MULT_CD(47 downto 32) <= std_logic_vector(unsigned(c11) * unsigned(d12) + unsigned(c12) * unsigned(d22));
  MULT_CD(31 downto 16) <= std_logic_vector(unsigned(c21) * unsigned(d11) + unsigned(c22) * unsigned(d21));
  MULT_CD(15 downto 0)  <= std_logic_vector(unsigned(c21) * unsigned(d12) + unsigned(c22) * unsigned(d22));
end process;

-- Soma matrizes MR1 + MR2 = MP
process(regMR1, regMR2)
  variable ab11, ab12, ab21, ab22: std_logic_vector(15 downto 0);
  variable cd11, cd12, cd21, cd22: std_logic_vector(15 downto 0);

begin
  ab11 := regMR1(63 downto 48);
  ab12 := regMR1(47 downto 32);
  ab21 := regMR1(31 downto 16);
  ab22 := regMR1(15 downto 0);

  cd11 := regMR2(63 downto 48);
  cd12 := regMR2(47 downto 32);
  cd21 := regMR2(31 downto 16);
  cd22 := regMR2(15 downto 0);

  SOMA_ABCD(63 downto 48) <= std_logic_vector(unsigned(ab11) + unsigned(cd11));
  SOMA_ABCD(47 downto 32) <= std_logic_vector(unsigned(ab12) + unsigned(cd12));
  SOMA_ABCD(31 downto 16) <= std_logic_vector(unsigned(ab21) + unsigned(cd21));
  SOMA_ABCD(15 downto 0)  <= std_logic_vector(unsigned(ab22) + unsigned(cd22));
end process;

-- Filtra matriz MP = MF
process(regMP)
  variable mf11, mf12, mf21, mf22: std_logic_vector(15 downto 0);

begin
  mf11 := regMP(63 downto 48);
  mf12 := regMP(47 downto 32);
  mf21 := regMP(31 downto 16);
  mf22 := regMP(15 downto 0);

  if unsigned(mf11) < 1050 then mf11 := (others => '0');
  else mf11 := mf11;
  end if;
  if unsigned(mf12) < 1050 then mf12 := (others => '0');
  else mf12 := mf12;
  end if;
  if unsigned(mf21) < 1050 then mf21 := (others => '0');
  else mf21 := mf21;
  end if;
  if unsigned(mf22) < 1050 then mf22 := (others => '0');
  else mf22 := mf22;
  end if;

  FILTRA_MF(63 downto 48) <= mf11;
  FILTRA_MF(47 downto 32) <= mf12;
  FILTRA_MF(31 downto 16) <= mf21;
  FILTRA_MF(15 downto 0)  <= mf22;
end process;

-- registrador matriz A
process (clk, rst)
begin
  if rst = '1' then
    regA <= (others => '0');
  elsif(clk'event and clk = '1') then
    if loadA = '1' then
      regA <= entA;
    else
      regA <= regA;
    end if;
  end if;
end process;

-- registrador matriz B
process (clk, rst)
begin
  if rst = '1' then
    regB <= (others => '0');
  elsif(clk'event and clk = '1') then
    if loadB = '1' then
      regB <= entB;
    else
      regB <= regB;
    end if;
  end if;
end process;

-- registrador matriz C
process (clk, rst)
begin
  if rst = '1' then
    regC <= (others => '0');
  elsif(clk'event and clk = '1') then
    if loadC = '1' then
      regC <= entC;
    else
      regC <= regC;
    end if;
  end if;
end process;

-- registrador matriz D
process (clk, rst)
begin
  if rst = '1' then
    regD <= (others => '0');
  elsif(clk'event and clk = '1') then
    if loadD = '1' then
      regD <= entD;
    else
      regD <= regD;
    end if;
  end if;
end process;

-- registrador matriz MR1
process (clk, rst)
begin
  if rst = '1' then
    regMR1 <= (others => '0');
  elsif(clk'event and clk = '1') then
    if loadMR1 = '1' then
      regMR1 <= MULT_AB;
    else
      regMR1 <= regMR1;
    end if;
  end if;
end process;

-- registrador matriz MR2
process (clk, rst)
begin
  if rst = '1' then
    regMR2 <= (others => '0');
  elsif(clk'event and clk = '1') then
    if loadMR2 = '1' then
      regMR2 <= MULT_CD;
    else
      regMR2 <= regMR2;
    end if;
  end if;
end process;

-- registrador matriz MP
process (clk, rst)
begin
  if rst = '1' then
    regMP <= (others => '0');
  elsif(clk'event and clk = '1') then
    if loadMP = '1' then
      regMP <= SOMA_ABCD;
    else
      regMP <= regMP;
    end if;
  end if;
end process;

-- registrador matriz MF
process (clk, rst)
begin
  if rst = '1' then
    regMF <= (others => '0');
  elsif(clk'event and clk = '1') then
    if loadMF = '1' then
      regMF <= FILTRA_MF;
    else
      regMF <= regMF;
    end if;
  end if;
end process;


-- controle
-- FSM
process(clk, rst)
begin
  if rst = '1' then
    estado <= s0;
  elsif clk'event and clk='1' then
    estado <= prox_estado;
  end if;
end process;

process(estado, start)
begin
  loadA <= '0'; loadB <= '0';
  loadC <= '0'; loadD <= '0';
  loadMR1 <= '0'; loadMR2 <= '0';
  loadMP <= '0'; loadMF <= '0';
  done <= '0';
  
  case estado is
    when s0 =>
      if start = '1' then
        prox_estado <= s1;
      else
        prox_estado <= s0;
      end if;

    when s1 =>
      loadA <= '1'; loadB <= '1';
      loadC <= '1'; loadD <= '1';
      prox_estado <= s2;
		
    when s2 =>
      loadMR1 <= '1';
      loadMR2 <= '1';
      prox_estado <= s3;

    when s3 =>
      loadMP <= '1';
      prox_estado <= s4;

    when s4 =>
      loadMF <= '1';
      prox_estado <= s5;

    when others =>
      done <= '1';
      prox_estado <= s5;
  end case;
end process;

saidaMF11 <= regMF(63 downto 48) when estado = s5 else (others => '0');
saidaMF12 <= regMF(47 downto 32) when estado = s5 else (others => '0');
saidaMF21 <= regMF(31 downto 16) when estado = s5 else (others => '0');
saidaMF22 <= regMF(15 downto 0)  when estado = s5 else (others => '0');

end Behavioral;