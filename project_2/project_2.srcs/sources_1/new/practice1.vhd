
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity state_prac is
generic(n: natural := 10);
  Port (sw : in  std_logic_vector(n-1 downto 0);
         z : out std_logic_vector(n-1 downto 0);
       sel : in std_logic_vector(1 downto 0);
        ck : in std_logic);
end state_prac;

architecture Behavioral of state_prac is
signal temp : std_logic_vector(n-1 downto 0);
begin

process(ck)
variable evenCtr : integer := 0;
variable oddCtr : integer := 1;
begin
if ck = '1' and ck'event then
    case sel is
        when "00" =>
            z <= sw;
        when "01" =>
            z <= sw((n/2) -1 downto 0) & sw(n-1 downto (n/2));
        when "10" =>
            z <= sw(n-2 downto 0) & sw(n-1);
        when "11" =>
            for i in 0 to (n/2) - 1 loop
                temp(i) <= sw(evenCtr);
                evenCtr := evenCtr + 2;
            end loop;
            for i in (n/2) to n-1 loop
                temp(i) <= sw(oddCtr);
                oddCtr := oddCtr + 2;
            end loop;
            evenCtr := 0;
            oddCtr := 1;
            z <= temp;
        end case;
end if;
end process;

end Behavioral;
