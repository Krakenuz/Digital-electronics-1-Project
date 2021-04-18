----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.04.2021 18:51:40
-- Design Name: 
-- Module Name: tb_relay_control - Behavioral
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

entity tb_relay_control is
--  Port ( );
end tb_relay_control;

architecture testbench of tb_relay_control is
    signal s_Passcode_1 :  std_logic_vector(4 - 1 downto 0);
    signal s_Passcode_2 :  std_logic_vector(4 - 1 downto 0);
    signal s_Passcode_3 :  std_logic_vector(4 - 1 downto 0);
    signal s_Passcode_4 :  std_logic_vector(4 - 1 downto 0);
    signal s_Display_1  :  std_logic_vector(4 - 1 downto 0);
    signal s_Display_2  :  std_logic_vector(4 - 1 downto 0);
    signal s_Display_3  :  std_logic_vector(4 - 1 downto 0);
    signal s_Display_4  :  std_logic_vector(4 - 1 downto 0);
    signal s_Relay_o    :  STD_LOGIC;

begin
    uut_relay_control : entity work.relay_control
        port map(
           Display_1	=>	s_Display_1,
           Display_2	=>	s_Display_2,
           Display_3	=>	s_Display_3,
           Display_4	=>	s_Display_4,
           Passcode_1   =>  s_Passcode_1,
           Passcode_2   =>  s_Passcode_2,
           Passcode_3   =>  s_Passcode_3,
           Passcode_4   =>  s_Passcode_4,
           Relay_o      =>  s_Relay_o
           );
           
    p_stimulus : process
    begin
        report "Stimulus process started" severity note;
            s_Passcode_1 <= "0001";
            s_Passcode_2 <= "0010";
            s_Passcode_3 <= "0011";
            s_Passcode_4 <= "0100";
            
            s_Display_1 <= "0001";
            s_Display_2 <= "0110";
            s_Display_3 <= "0011";
            s_Display_4 <= "0110";
            wait for 20ns;
            
            s_Display_1 <= "0001";
            s_Display_2 <= "0010";
            s_Display_3 <= "0011";
            s_Display_4 <= "0100";
            wait for 20ns;
            
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
end testbench;