library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity max_array is
generic(L: natural := 10;
        N: natural := 8);
Port (x: in  std_logic_vector(N*L-1 downto 0);
      z: out std_logic_vector(N-1 downto 0));
end max_array;

architecture Behavioral of max_array is

-- set up component
component PE is
Generic (N: integer:= 8);
Port (x, y: in  std_logic_vector(N-1 downto 0);
         z: out std_logic_vector(N-1 downto 0));
end component;

-- set up variables
signal start : std_logic_vector(N-1 downto 0);
type vector_array is array (natural range <> ) of std_logic_vector (N-1 downto 0);
signal temp: vector_array(L-1 downto 0);

begin

temp(L-1) <= (others => '0');

G1: for i in L-1 downto 0 generate -- run down each element from L-1 downto 0

G2: if i = L-1 generate
cell: PE generic map(N)
      port map(x((N*L-1)downto N*(L-1)), temp(i), temp(i-1)); -- Compares using given algorithm
end generate G2;

G3: if i>0 and i<L-1 generate
cell: PE generic map(N)
      port map(x((N*i+N-1)downto N*i), temp(i), temp(i-1)); -- Compares using given algorithm
end generate G3;

G4: if i=0 generate
cell: PE generic map(N)
      port map(x(N-1 downto 0), temp(i), z); -- Compares using given algorithm
end generate G4;

end generate G1;
end Behavioral;
