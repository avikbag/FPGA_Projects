library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity max_array5x3 is
--generic(A: natural := 5;
--        B: natural := 3);
Port (sw: in  std_logic_vector(14 downto 0);
      z: out std_logic_vector(2 downto 0));
end max_array5x3;

architecture Struct of max_array5x3 is

component max_array is
generic(L: natural := 10;
        N: natural := 8);
Port (x: in  std_logic_vector(N*L-1 downto 0);
      z: out std_logic_vector(N-1 downto 0));
end component;

begin

U1: max_array generic map(5,3)
    port map(sw, z);

end Struct;