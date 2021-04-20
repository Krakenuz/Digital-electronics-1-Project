----------------------------------------------------------------------------------
-- Company: 
-- Engeer: 
-- 
-- Create Date: 14.04.2021 15:52:49
-- Design Name: 
-- Module Name: tb_display_control - Behavioral
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

-- Uncomment the followg library declaration if usg
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the followg library declaration if stantiatg
-- any Xilx leaf cells  this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_display_control is
--  Port ( );
end tb_display_control;

architecture testbench of tb_display_control is
    signal s_Button_0 :  STD_LOGIC;
    signal s_Button_1 :  STD_LOGIC;
    signal s_Button_2 :  STD_LOGIC;
    signal s_Button_3 :  STD_LOGIC;
    signal s_Button_4 :  STD_LOGIC;
    signal s_Button_5 :  STD_LOGIC;
    signal s_Button_6 :  STD_LOGIC;
    signal s_Button_7 :  STD_LOGIC;
    signal s_Button_8 :  STD_LOGIC;
    signal s_Button_9 :  STD_LOGIC;
    signal s_Button_RESET :  STD_LOGIC;
    signal s_Button_SET :  STD_LOGIC;         
    signal s_Display_1 :  std_logic_vector(4 - 1 downto 0);
    signal s_Display_2 :  std_logic_vector(4 - 1 downto 0);
    signal s_Display_3 :  std_logic_vector(4 - 1 downto 0);
    signal s_Display_4 :  std_logic_vector(4 - 1 downto 0);
    signal s_Passcode_1 :  std_logic_vector(4 - 1 downto 0);
    signal s_Passcode_2 :  std_logic_vector(4 - 1 downto 0);
    signal s_Passcode_3 :  std_logic_vector(4 - 1 downto 0);
    signal s_Passcode_4 :  std_logic_vector(4 - 1 downto 0);

begin
	uut_display_control : entity work.display_control
        port map(
            Button_0	=>	s_Button_0,
            Button_1	=>	s_Button_1,
            Button_2	=>  s_Button_2,
            Button_3	=>	s_Button_3,
            Button_4	=>	s_Button_4,
            Button_5	=>	s_Button_5,
            Button_6	=>	s_Button_6,
            Button_7	=>	s_Button_7,
            Button_8	=>	s_Button_8,
            Button_9	=>	s_Button_9,
            Button_RESET	=>	s_Button_RESET,
            Button_SET	=>	s_Button_SET,
           Display_1	=>	s_Display_1,
           Display_2	=>	s_Display_2,
           Display_3	=>	s_Display_3,
           Display_4	=>	s_Display_4,
           Passcode_1   => s_Passcode_1,
           Passcode_2   => s_Passcode_2,
           Passcode_3   => s_Passcode_3,
           Passcode_4   => s_Passcode_4);

	p_stimulus : process
    begin
        report "Stimulus process started" severity note;
        s_Button_1 <= '0';
        wait for 10ns;
        s_Button_1 <= '1';
        s_Button_0 <= '0';
        s_Button_2 <= '0';
        s_Button_3 <= '0';
        s_Button_4 <= '0';
        s_Button_5 <= '0';
        s_Button_6 <= '0';
        s_Button_7 <= '0';
        s_Button_8 <= '0';
        s_Button_9 <= '0';
        s_Button_RESET <= '0';
        s_Button_SET <= '0';
		wait for 50ns;
		s_Button_1 <= '0';
		wait for 10ns;
		s_Button_1 <= '1';
		wait for 50ns;
		s_Button_1 <= '0';
		wait for 10ns;
		
		s_Button_9 <= '1';
		wait for 50ns;
		s_Button_9 <= '0';
		wait for 10ns;
		
		s_Button_6 <= '1';
		wait for 50ns;
		s_Button_6 <= '0';
		wait for 10ns;
		
		s_Button_RESET <= '1';
		wait for 50ns;
		s_Button_RESET <= '0';
		wait for 10ns;
		
		s_Button_4 <= '1';
		wait for 50ns;
		s_Button_4 <= '0';
		wait for 10ns;
		
		s_Button_5 <= '1';
		wait for 50ns;
		s_Button_5 <= '0';
		wait for 10ns;
		
		s_Button_8 <= '1';
		wait for 50ns;
		s_Button_8 <= '0';
		wait for 10ns;
		
		s_Button_3 <= '1';
		wait for 50ns;
		s_Button_3 <= '0';
		wait for 10ns;
		
		s_Button_SET <='1';
		wait for 50ns;
		s_Button_SET <='0';
		wait for 10ns;
		
		s_Button_RESET <= '1';
		wait for 50ns;
		s_Button_RESET <= '0';
		wait for 10ns;
		
		s_Button_4 <= '1';
		wait for 50ns;
		s_Button_4 <= '0';
		wait for 10ns;
		
		s_Button_5 <= '1';
		wait for 50ns;
		s_Button_5 <= '0';
		wait for 10ns;
		
		s_Button_8 <= '1';
		wait for 50ns;
		s_Button_8 <= '0';
		wait for 10ns;
		
		s_Button_3 <= '1';
		wait for 50ns;
		s_Button_3 <= '0';
		wait for 10ns;
		
		s_Button_SET <='1';
		wait for 50ns;
		s_Button_SET <='0';
		wait for 10ns;
		
		s_Button_9 <= '1';
		wait for 50ns;
		s_Button_9 <= '0';
		wait for 10ns;
		
		s_Button_6 <= '1';
		wait for 50ns;
		s_Button_6 <= '0';
		wait for 10ns;
		
		s_Button_9 <= '1';
		wait for 50ns;
		s_Button_9 <= '0';
		wait for 50ns;
		
		s_Button_6 <= '1';
		wait for 50ns;
		s_Button_6 <= '0';
		wait for 10ns;
		
		s_Button_SET <='1';
		wait for 50ns;
		s_Button_SET <='0';
		wait for 10ns;
		
		s_Button_RESET <= '1';
		wait for 50ns;
		s_Button_RESET <= '0';
		wait for 10ns;
		
		s_Button_9 <= '1';
		wait for 50ns;
		s_Button_9 <= '0';
		wait for 10ns;
		
		s_Button_6 <= '1';
		wait for 50ns;
		s_Button_6 <= '0';
		wait for 10ns;
		
		s_Button_9 <= '1';
		wait for 50ns;
		s_Button_9 <= '0';
		wait for 50ns;
		
		s_Button_5 <= '1';
		wait for 50ns;
		s_Button_5 <= '0';
		wait for 10ns;
		
		s_Button_SET <='1';
		wait for 50ns;
		s_Button_SET <='0';
		wait for 10ns;
		
		s_Button_9 <= '1';
		wait for 50ns;
		s_Button_9 <= '0';
		wait for 10ns;
		
		s_Button_6 <= '1';
		wait for 50ns;
		s_Button_6 <= '0';
		wait for 10ns;
		
		s_Button_9 <= '1';
		wait for 50ns;
		s_Button_9 <= '0';
		wait for 50ns;
		
		s_Button_6 <= '1';
		wait for 50ns;
		s_Button_6 <= '0';
		wait for 10ns;
		
		s_Button_SET <='1';
		wait for 50ns;
		s_Button_SET <='0';
		wait for 10ns;
		
		s_Button_1 <= '1';
		wait for 50ns;
		s_Button_1 <= '0';
		wait for 10ns;
		
		s_Button_2 <= '1';
		wait for 50ns;
		s_Button_2 <= '0';
		wait for 10ns;
		
		s_Button_3 <= '1';
		wait for 50ns;
		s_Button_3 <= '0';
		wait for 50ns;
		
		s_Button_4 <= '1';
		wait for 50ns;
		s_Button_4 <= '0';
		wait for 10ns;
		
		s_Button_SET <='1';
		wait for 50ns;
		s_Button_SET <='0';
		wait for 10ns;
		
		s_Button_2 <= '1';
		wait for 50ns;
		s_Button_2 <= '0';
		wait for 10ns;
		
		s_Button_3 <= '1';
		wait for 50ns;
		s_Button_3 <= '0';
		wait for 10ns;
		
		s_Button_4 <= '1';
		wait for 50ns;
		s_Button_4 <= '0';
		wait for 50ns;
		
		s_Button_5 <= '1';
		wait for 50ns;
		s_Button_5 <= '0';
		wait for 10ns;
		
		s_Button_SET <='1';
		wait for 50ns;
		s_Button_SET <='0';
		wait for 10ns;
		
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
end testbench;
