----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.04.2021 18:15:58
-- Design Name: 
-- Module Name: relay_control - Behavioral
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

entity relay_control is
    Port (     
           Passcode_1   : in std_logic_vector(4 - 1 downto 0);
           Passcode_2   : in std_logic_vector(4 - 1 downto 0);
           Passcode_3   : in std_logic_vector(4 - 1 downto 0);
           Passcode_4   : in std_logic_vector(4 - 1 downto 0);
           Display_1    : in std_logic_vector(4 - 1 downto 0);
           Display_2    : in std_logic_vector(4 - 1 downto 0);
           Display_3    : in std_logic_vector(4 - 1 downto 0);
           Display_4    : in std_logic_vector(4 - 1 downto 0);
           Relay_o      : out STD_LOGIC
         );
end relay_control;

architecture Behavioral of relay_control is

begin
    p_relay_control : process(Passcode_1,Passcode_2,Passcode_3,Passcode_4,Display_1,Display_2,Display_3,Display_4)
        begin
            if (Display_1 = Passcode_1 and Display_2 = Passcode_2 and Display_3 = Passcode_3 and Display_4 = Passcode_4) then
                Relay_o <= '1';
            else
                Relay_o <= '0';
            end if;
    end process p_relay_control;

end Behavioral;
