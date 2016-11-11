library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
--use IEEE.numeric_std.all;

entity rad_add is
Generic(r: natural := 12;
        n: natural := 4);
Port ( x,y : in STD_LOGIC_VECTOR(n-1 downto 0);
ck, btn0, btn1, reset: in STD_LOGIC;
         z : out STD_LOGIC_VECTOR(n-1 downto 0));
end rad_add;

architecture Behavioral of rad_add is
-- Variable initialization
signal temp_x, temp_y : STD_LOGIC_VECTOR(n downto 0);
type db_state is (not_rdy, rdy, pulse);
signal db_ns : db_state;
signal clk : STD_LOGIC;
signal lsf : std_logic_vector(n downto 0);
signal msf : std_logic_vector(n downto 0);

type rad_state is (no_carry, carry, finish);
signal rad_ns : rad_state;

begin

temp_x <= '0'&x;
temp_y <= '0'&y;

process (ck, btn0, btn1) -- debouncing 
begin
if ck = '1' and ck'event then 
    case db_ns is
        when not_rdy =>
            if btn0 = '1' then 
                db_ns <= rdy;
            end if;
                clk <= '0';
        when rdy =>
            if btn1 = '1' then 
                db_ns <= pulse;
            end if;
                clk <= '0';
        when pulse =>
            db_ns <= not_rdy;
            clk <= '1';
        when others =>
            NULL;
    end case;
end if;
end process;

process(clk, reset)
variable temp2 : integer;
variable temp : std_logic_vector(n downto 0);

begin
    if clk = '1' and clk'event then 
        if reset = '1' then 
            rad_ns <= no_carry;
            z <= (others =>'0');
        else
            case rad_ns is 
                when no_carry =>
                    temp := unsigned(temp_x) + unsigned(temp_y);
                    if unsigned(temp) > r-1 then 
                        rad_ns <= carry;
                    else   
                        z <= temp(n-1 downto 0);
                    end if;
                when carry => 
                    temp := temp - r;
                    temp2 := temp2 + 1;
                    if temp > r-1 then 
                        rad_ns <= carry;
                    else
                        z <= temp(n-1 downto 0);
                        rad_ns <= finish;
                    end if;
                when finish =>
                    z <= conv_std_logic_vector(temp2,n);
            end case;
        end if;
    end if;
end process;

end Behavioral;
