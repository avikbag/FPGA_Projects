library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity fifo_4x16 is
  Port (ck, btn0, btn1, reset, wen, ren : in std_logic;
        x : in std_logic_vector(3 downto 0);
        z : out std_logic_vector(3 downto 0);
        empty_flag, full_flag : out std_logic
        );
end fifo_4x16;

architecture Behavioral of fifo_4x16 is

component fifo_generator_0 
  PORT (
    clk : IN STD_LOGIC;
    rst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC
  );
END component;

signal en : std_logic;
signal temp : std_logic_vector(3 downto 0);
signal readin : std_logic;

begin

U1: fifo_generator_0
    port map(clk => en,
             rst => reset,
             din => x,
             wr_en => wen,
             rd_en => readin,
             dout => z,
             full => full_flag,
             empty => empty_flag);


process(ck)
type db_state is (not_rdy, rdy, pulse);
variable db_ns : db_state;
variable count : integer;
variable ctr1 : integer;
variable ctr2 : integer;
begin 

-- start checking at every rising clock event
if ck = '1' and ck'event then
    if wen = '1' and ctr1 <= 20 then
        
--        if chk < 5 then -- remove latency 
--            temp <= "0000";
--            chk := chk + 1;
--            en <= '1';
--        else
            case db_ns is 
               when not_rdy =>
                    en <= '0';
                    if btn0 = '1' then 
                        db_ns := rdy;
                    end if;
                when rdy =>
                    en <= '0';
                    if btn1 = '1' then 
                        db_ns := pulse;
                    end if;
                when pulse =>
                    en <= '1';
--                    temp <= x;
                      ctr1 := ctr1 + 1;  
                    db_ns := not_rdy;
                when others =>
                    NULL;
            end case; 
--        end if;
--    elsif reset = '1' then 
--        ctr1 := 0;
--        ctr2 := 0;
--        readin <= '0';
--        db_ns := not_rdy;    
    else
        if count = 99999999 then 
            en <= not en;
            
            count := 0;
            ctr2 := ctr2 + 1;
            readin <='1';
            if ctr2 = ctr1 then 
                ctr1 := 0;
                ctr2 := 0;
                readin <= '0';
            end if;
        else 
            count := count + 1;
        end if;
   
end if;
end if;
end process;

end Behavioral;