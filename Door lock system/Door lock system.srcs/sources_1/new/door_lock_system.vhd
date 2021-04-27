----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.04.2021 20:11:48
-- Design Name: 
-- Module Name: door_lock_system - Behavioral
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

entity door_lock_system is
    Port ( clk     : in  std_logic;
           Button_0 : in STD_LOGIC;
           Button_1 : in STD_LOGIC;
           Button_2 : in STD_LOGIC;
           Button_3 : in STD_LOGIC;
           Button_4 : in STD_LOGIC;
           Button_5 : in STD_LOGIC;
           Button_6 : in STD_LOGIC;
           Button_7 : in STD_LOGIC;
           Button_8 : in STD_LOGIC;
           Button_9 : in STD_LOGIC;
           Button_RESET : in STD_LOGIC;
           Button_SET : in STD_LOGIC;
           Relay_o      : out STD_LOGIC;
           seg_o : out std_logic_vector(7 - 1 downto 0);
           seg_2_o : out std_logic_vector(7 - 1 downto 0);
           seg_3_o : out std_logic_vector(7 - 1 downto 0);
           seg_4_o : out std_logic_vector(7 - 1 downto 0)
    );
end door_lock_system;

architecture Behavioral of door_lock_system is
    signal internal_Display_1 : std_logic_vector(4 - 1 downto 0);
    signal internal_Display_2 : std_logic_vector(4 - 1 downto 0);
    signal internal_Display_3 : std_logic_vector(4 - 1 downto 0);
    signal internal_Display_4 : std_logic_vector(4 - 1 downto 0);
    signal internal_Passcode_1   : std_logic_vector(4 - 1 downto 0);
    signal internal_Passcode_2   : std_logic_vector(4 - 1 downto 0);
    signal internal_Passcode_3   : std_logic_vector(4 - 1 downto 0);
    signal internal_Passcode_4   : std_logic_vector(4 - 1 downto 0);
begin
        disp_cnt: entity work.display_control
        port map (
            Button_0=>Button_0,
            Button_1=>Button_1,
            Button_2=>Button_2,
            Button_3=>Button_3,
            Button_4=>Button_4,
            Button_5=>Button_5,
            Button_6=>Button_6,
            Button_7=>Button_7,
            Button_8=>Button_8,
            Button_9=>Button_9,
            Button_RESET=>Button_RESET,
            Button_SET=>Button_SET,        
           Display_1=>internal_Display_1,
           Display_2=>internal_Display_2,
           Display_3=>internal_Display_3,
           Display_4=>internal_Display_4,
           Passcode_1=>internal_Passcode_1,
           Passcode_2=>internal_Passcode_2,
           Passcode_3=>internal_Passcode_3,
           Passcode_4=>internal_Passcode_4,
           clk=>clk
        );
        
        relay_cnt: entity work.relay_control
            port map (
                Passcode_1=>internal_Passcode_1,
                Passcode_2=>internal_Passcode_2,
                Passcode_3=>internal_Passcode_3,
                Passcode_4=>internal_Passcode_4,
                Display_1=>internal_Display_1,
                Display_2=>internal_Display_2,
                Display_3=>internal_Display_3,
                Display_4=>internal_Display_4,
                Relay_o=>Relay_o
            ); 
        
        hex_7seg: entity work.hex_7seg
            port map(
                hex_i=>internal_Display_1,
                hex_2_i=>internal_Display_2,
                hex_3_i=>internal_Display_3,
                hex_4_i=>internal_Display_4,
                seg_o=>seg_o,
                seg_2_o=>seg_2_o,
                seg_3_o=>seg_3_o,
                seg_4_o=>seg_4_o
            );    

end Behavioral;
