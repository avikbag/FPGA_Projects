----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/26/2015 01:07:07 PM
-- Design Name: 
-- Module Name: fifo_4x16 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

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

begin

U1: fifo_generator_0
    port map(clk => en,
             rst => reset,
             din => x,
             wr_en => wen,
             rd_en => ren,
             dout => z,
             full => full_flag,
             empty => empty_flag);

process(ck)
type db_state is (not_rdy, rdy, pulse);
variable db_ns : db_state;
begin 
if ck = '1' and ck'event then 
    case db_ns is 
        when not_rdy =>
            en <= '0';
            if btn1 = '1' then 
                db_ns := rdy;
            end if;
        when rdy =>
            en <= '0';
            if btn1 = '1' then 
                db_ns := pulse;
            end if;
        when pulse =>
            en <= '1';
            db_ns := not_rdy;
        when others =>
            NULL;
    end case;
end if;
end process;

end Behavioral;
