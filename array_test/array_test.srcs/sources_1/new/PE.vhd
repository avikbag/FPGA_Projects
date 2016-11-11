library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_unsigned.all;

entity PE is
Generic (N: integer:= 8);
Port (x, y: in  std_logic_vector(N-1 downto 0);
         z: out std_logic_vector(N-1 downto 0));
end PE;

architecture Behavioral of PE is
begin

process(x,y)
begin

if unsigned(x) > unsigned(y) then
    z <= x;
else 
    z <= y;
end if;

end process;

end Behavioral;