----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2021 12:48:14
-- Design Name: 
-- Module Name: display_control - Behavioral
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

entity display_control is
    Port ( Button_0 : in STD_LOGIC;
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
           Display_1 : out std_logic_vector(4 - 1 downto 0);
           Display_2 : out std_logic_vector(4 - 1 downto 0);
           Display_3 : out std_logic_vector(4 - 1 downto 0);
           Display_4 : out std_logic_vector(4 - 1 downto 0));
end display_control;

architecture Behavioral of display_control is
    -- Pomocn� vektor tla��tka
    signal Buttons  : std_logic_vector(12 - 1 downto 0);
    -- 
    signal cnt : natural;
begin
p_display_control: process(Button_0,Button_1,Button_2,Button_3,Button_4,Button_5,Button_6,Button_7,Button_8,Button_9,Button_Reset,Button_SET)
begin 
    Buttons(0) <= Button_0;
    Buttons(1) <= Button_1;
    Buttons(2) <= Button_2;
    Buttons(3) <= Button_3;
    Buttons(4) <= Button_4;
    Buttons(5) <= Button_5;
    Buttons(6) <= Button_6;
    Buttons(7) <= Button_7;
    Buttons(8) <= Button_8;
    Buttons(9) <= Button_9;
    Buttons(10) <= Button_RESET;
    Buttons(11) <= Button_SET;
    
    if (rising_edge(Button_0) or rising_edge(Button_1)or rising_edge(Button_2)or rising_edge(Button_3)or rising_edge(Button_4)or rising_edge(Button_5)or rising_edge(Button_6)or rising_edge(Button_7)or rising_edge(Button_8)or rising_edge(Button_9)or rising_edge(Button_RESET)or rising_edge(Button_SET)) then
        cnt <=cnt+1; 
        
    end if;
    
    case Buttons is
        when "000000000001" =>
            case cnt is
                when 1 =>
                    Display_1<="0000";
                when 2 =>
                    Display_2<="0000";
                when 3 =>
                    Display_3<="0000";
                when 4 =>
                    Display_4<="0000";
                when others =>    
            end case;
        when "000000000010" =>
            case cnt is
                when 1 =>
                    Display_1<="0001";
                when 2 =>
                    Display_2<="0001";
                when 3 =>
                    Display_3<="0001";
                when 4 =>
                    Display_4<="0001";
                    when others =>   
            end case;   
        when "000000000100" =>
            case cnt is
                when 1 =>
                    Display_1<="0010";
                when 2 =>
                    Display_2<="0010";
                when 3 =>
                    Display_3<="0010";
                when 4 =>
                    Display_4<="0010";
                    when others =>   
            end case;   
        when "000000001000" =>
            case cnt is
                when 1 =>
                    Display_1<="0011";
                when 2 =>
                    Display_2<="0011";
                when 3 =>
                    Display_3<="0011";
                when 4 =>
                    Display_4<="0011";
                    when others =>   
            end case;   
        when "000000010000" =>
            case cnt is
                when 1 =>
                    Display_1<="0100";
                when 2 =>
                    Display_2<="0100";
                when 3 =>
                    Display_3<="0100";
                when 4 =>
                    Display_4<="0100";
                    when others =>   
            end case;   
        when "000000100000" =>
            case cnt is
                when 1 =>
                    Display_1<="0101";
                when 2 =>
                    Display_2<="0101";
                when 3 =>
                    Display_3<="0101";
                when 4 =>
                    Display_4<="0101";
                    when others =>   
            end case;   
        when "000001000000" =>
            case cnt is
                when 1 =>
                    Display_1<="0110";
                when 2 =>
                    Display_2<="0110";
                when 3 =>
                    Display_3<="0110";
                when 4 =>
                    Display_4<="0110";
                    when others =>   
            end case;   
        when "000010000000" =>
            case cnt is
                when 1 =>
                    Display_1<="0111";
                when 2 =>
                    Display_2<="0111";
                when 3 =>
                    Display_3<="0111";
                when 4 =>
                    Display_4<="0111";
                    when others =>   
            end case;   
        when "000100000000" =>
            case cnt is
                when 1 =>
                    Display_1<="1000";
                when 2 =>
                    Display_2<="1000";
                when 3 =>
                    Display_3<="1000";
                when 4 =>
                    Display_4<="1000";
                    when others =>   
            end case;   
        when "001000000000" =>
            case cnt is
                when 1 =>
                    Display_1<="1001";
                when 2 =>
                    Display_2<="1001";
                when 3 =>
                    Display_3<="1001";
                when 4 =>
                    Display_4<="1001";
                    when others =>   
            end case;   
        when "010000000000" =>      --RESET
            Display_1<="0000";
            Display_2<="0000";
            Display_3<="0000";
            Display_4<="0000";
            cnt<=0;
        when "100000000000" =>     --SET
            --domyslet
        when others =>   
        
    end case;   
    --if (cnt >=4) then         --P�episovat ��slice bez resetu
      --      cnt<=0;
      --  end if;                                                                                                          
end process p_display_control;
end Behavioral;
