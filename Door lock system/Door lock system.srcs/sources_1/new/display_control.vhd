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
use ieee.numeric_std.all;
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
           Display_4 : out std_logic_vector(4 - 1 downto 0);
           Passcode_1   : out std_logic_vector(4 - 1 downto 0);
           Passcode_2   : out std_logic_vector(4 - 1 downto 0);
           Passcode_3   : out std_logic_vector(4 - 1 downto 0);
           Passcode_4   : out std_logic_vector(4 - 1 downto 0);
           Relay_o      : out STD_LOGIC;
           seg_o : out std_logic_vector(7 - 1 downto 0);
           seg_2_o : out std_logic_vector(7 - 1 downto 0);
           seg_3_o : out std_logic_vector(7 - 1 downto 0);
           seg_4_o : out std_logic_vector(7 - 1 downto 0);
           clk   : in  std_logic);
end display_control;

architecture Behavioral of display_control is
    -- Pomocn� vektor tla��tka
    signal Buttons  : std_logic_vector(12 - 1 downto 0);
    -- 
    signal internal_Display_1 : std_logic_vector(4 - 1 downto 0);
    signal internal_Display_2 : std_logic_vector(4 - 1 downto 0);
    signal internal_Display_3 : std_logic_vector(4 - 1 downto 0);
    signal internal_Display_4 : std_logic_vector(4 - 1 downto 0);
    signal internal_Passcode_1   : std_logic_vector(4 - 1 downto 0);
    signal internal_Passcode_2   : std_logic_vector(4 - 1 downto 0);
    signal internal_Passcode_3   : std_logic_vector(4 - 1 downto 0);
    signal internal_Passcode_4   : std_logic_vector(4 - 1 downto 0);
        signal internal2_Display_1 : std_logic_vector(4 - 1 downto 0);
    signal internal2_Display_2 : std_logic_vector(4 - 1 downto 0);
    signal internal2_Display_3 : std_logic_vector(4 - 1 downto 0);
    signal internal2_Display_4 : std_logic_vector(4 - 1 downto 0);
    signal internal2_Passcode_1   : std_logic_vector(4 - 1 downto 0);
    signal internal2_Passcode_2   : std_logic_vector(4 - 1 downto 0);
    signal internal2_Passcode_3   : std_logic_vector(4 - 1 downto 0);
    signal internal2_Passcode_4   : std_logic_vector(4 - 1 downto 0);
    signal cnt : natural;
    signal reset_cnt:std_logic;
    signal reset_disp:std_logic;
    signal set_disp:std_logic;
    signal set_password : boolean;
    signal display_time : natural;
begin
p_display_control: process(clk,Button_0,Button_1,Button_2,Button_3,Button_4,Button_5,Button_6,Button_7,Button_8,Button_9,Button_Reset,Button_SET,cnt,Buttons,display_time,reset_cnt)
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
    if (rising_edge(Button_0) or rising_edge(Button_1)or rising_edge(Button_2)or rising_edge(Button_3)or rising_edge(Button_4)or rising_edge(Button_5)or rising_edge(Button_6)or rising_edge(Button_7)or rising_edge(Button_8)or rising_edge(Button_9)) then
        if cnt<4 then
        cnt <=cnt+1;
        end if;
    end if;
    if(rising_edge(Button_SET)) then
            if (internal_Passcode_1 ="UUUU") then
             
                internal_Passcode_1 <= internal_Display_1;
                internal_Passcode_2 <= internal_Display_2;
                internal_Passcode_3 <= internal_Display_3;
                internal_Passcode_4 <= internal_Display_4;
                set_disp<='1';
            else
            if (internal_Display_1 = internal_Passcode_1 and internal_Display_2 = internal_Passcode_2 and internal_Display_3 = internal_Passcode_3 and internal_Display_4 = internal_Passcode_4) then
                --Vynulov�n� displaye p�ed nastaven�m nov�ho hesla
               
                internal_Display_1<="0000";
                internal_Display_2<="0000";
                internal_Display_3<="0000";
                internal_Display_4<="0000";
                
                reset_cnt<='1';
                reset_disp<='1';
                --nastaven� nov�ho hesla
                set_password<=true;
            else
            if (set_password=true) then
               
                internal_Passcode_1 <= internal_Display_1;
                internal_Passcode_2 <= internal_Display_2;
                internal_Passcode_3 <= internal_Display_3;
                internal_Passcode_4 <= internal_Display_4;
                
                set_disp<='1';
                set_password<=false;
            end if;
            end if;
            end if;
            end if;
    if(reset_cnt='1') then
    cnt<=0;
    reset_cnt<='0';
    end if;
    if(reset_disp='1') then
        internal2_Display_1<="0000";
        internal2_Display_2<="0000";
        internal2_Display_3<="0000";
        internal2_Display_4<="0000";
    reset_disp<='0';
    end if; 
    if(set_disp='1') then
        internal2_Passcode_1 <= internal2_Display_1;
        internal2_Passcode_2 <= internal2_Display_2;
        internal2_Passcode_3 <= internal2_Display_3;
        internal2_Passcode_4 <= internal2_Display_4;
    set_disp<='0';
    end if; 
    case Buttons is
        when "000000000001" =>  --0
            case cnt is
                when 1 =>
                   -- Display_1<="0000";
                    internal_Display_1<="0000";
                    internal2_Display_1<="0000";
                when 2 =>
                   -- Display_2<="0000";
                    internal_Display_2<="0000";
                    internal2_Display_2<="0000";
                when 3 =>
                   -- Display_3<="0000";
                    internal_Display_3<="0000";
                    internal2_Display_3<="0000";
                when 4 =>
                   -- Display_4<="0000";
                    internal_Display_4<="0000";
                    internal2_Display_4<="0000";
                when others =>    
            end case;
        when "000000000010" => --1
            case cnt is
                when 1 =>
                   -- Display_1<="0001";
                    internal_Display_1<="0001";
                    internal2_Display_1<="0001";
                when 2 =>
                   -- Display_2<="0001";
                    internal_Display_2<="0001";
                    internal2_Display_2<="0001";
                when 3 =>
                   -- Display_3<="0001";
                    internal_Display_3<="0001";
                    internal2_Display_3<="0001";
                when 4 =>
                   -- Display_4<="0001";
                    internal_Display_4<="0001";
                    internal2_Display_4<="0001";
                    when others =>   
            end case;   
        when "000000000100" =>
            case cnt is
                when 1 =>
                   -- Display_1<="0010";
                    internal_Display_1<="0010";
                    internal2_Display_1<="0010";
                when 2 =>
                   -- Display_2<="0010";
                    internal_Display_2<="0010";
                    internal2_Display_2<="0010";
                when 3 =>
                   -- Display_3<="0010";
                    internal_Display_3<="0010";
                    internal2_Display_3<="0010";
                when 4 =>
                   -- Display_4<="0010";
                    internal_Display_4<="0010";
                    internal2_Display_4<="0010";
                    when others =>   
            end case;   
        when "000000001000" =>
            case cnt is
                when 1 =>
                   -- Display_1<="0011";
                    internal_Display_1<="0011";
                    internal2_Display_1<="0011";
                when 2 =>
                   -- Display_2<="0011";
                    internal_Display_2<="0011";
                    internal2_Display_2<="0011";
                when 3 =>
                   -- Display_3<="0011";
                    internal_Display_3<="0011";
                    internal2_Display_3<="0011";
                when 4 =>
                   -- Display_4<="0011";
                    internal_Display_4<="0011";
                    internal2_Display_4<="0011";
                    when others =>   
            end case;   
        when "000000010000" =>
            case cnt is
                when 1 =>
                   -- Display_1<="0100";
                    internal_Display_1<="0100";
                    internal2_Display_1<="0100";
                when 2 =>
                   -- Display_2<="0100";
                    internal_Display_2<="0100";
                    internal2_Display_2<="0100";
                when 3 =>
                   -- Display_3<="0100";
                    internal_Display_3<="0100";
                    internal2_Display_3<="0100";
                when 4 =>
                   -- Display_4<="0100";
                    internal_Display_4<="0100";
                    internal2_Display_4<="0100";
                    when others =>   
            end case;   
        when "000000100000" =>
            case cnt is
                when 1 =>
                   -- Display_1<="0101";
                    internal_Display_1<="0101";
                    internal2_Display_1<="0101";
                when 2 =>
                   -- Display_2<="0101";
                    internal_Display_2<="0101";
                    internal2_Display_2<="0101";
                when 3 =>
                   -- Display_3<="0101";
                    internal_Display_3<="0101";
                    internal2_Display_3<="0101";
                when 4 =>
                   -- Display_4<="0101";
                    internal_Display_4<="0101";
                    internal2_Display_4<="0101";
                    when others =>   
            end case;   
        when "000001000000" =>
            case cnt is
                when 1 =>
                   -- Display_1<="0110";
                    internal_Display_1<="0110";
                    internal2_Display_1<="0110";
                when 2 =>
                   -- Display_2<="0110";
                    internal_Display_2<="0110";
                    internal2_Display_2<="0110";
                when 3 =>
                   -- Display_3<="0110";
                    internal_Display_3<="0110";
                    internal2_Display_3<="0110";
                when 4 =>
                   -- Display_4<="0110";
                    internal_Display_4<="0110";
                    internal2_Display_4<="0110";
                    when others =>   
            end case;   
        when "000010000000" =>
            case cnt is
                when 1 =>
                   -- Display_1<="0111";
                    internal_Display_1<="0111";
                    internal2_Display_1<="0111";
                when 2 =>
                   -- Display_2<="0111";
                    internal_Display_2<="0111";
                    internal2_Display_2<="0111";
                when 3 =>
                   -- Display_3<="0111";
                    internal_Display_3<="0111";
                    internal2_Display_3<="0111";
                when 4 =>
                   -- Display_4<="0111";
                    internal_Display_4<="0111";
                    internal2_Display_4<="0111";
                    when others =>   
            end case;   
        when "000100000000" =>
            case cnt is
                when 1 =>
                   -- Display_1<="1000";
                    internal_Display_1<="1000";
                    internal2_Display_1<="1000";
                when 2 =>
                   -- Display_2<="1000";
                    internal_Display_2<="1000";
                    internal2_Display_2<="1000";
                when 3 =>
                   -- Display_3<="1000";
                    internal_Display_3<="1000";
                    internal2_Display_3<="1000";
                when 4 =>
                   -- Display_4<="1000";
                    internal_Display_4<="1000";
                    internal2_Display_4<="1000";
                    when others =>   
            end case;   
        when "001000000000" =>
            case cnt is
                when 1 =>
                   -- Display_1<="1001";
                    internal_Display_1<="1001";
                    internal2_Display_1<="1001";
                when 2 =>
                   -- Display_2<="1001";
                    internal_Display_2<="1001";
                    internal2_Display_2<="1001";
                when 3 =>
                   -- Display_3<="1001";
                    internal_Display_3<="1001";
                    internal2_Display_3<="1001";
                when 4 =>
                   -- Display_4<="1001";
                    internal_Display_4<="1001";
                    internal2_Display_4<="1001";
                    when others =>   
            end case;   
        when "010000000000" =>      --RESET
           -- Display_1<="0000";
           -- Display_2<="0000";
           -- Display_3<="0000";
           -- Display_4<="0000";
            internal_Display_1<="0000";
            internal_Display_2<="0000";
            internal_Display_3<="0000";
            internal_Display_4<="0000";
            internal2_Display_1<="0000";
            internal2_Display_2<="0000";
            internal2_Display_3<="0000";
            internal2_Display_4<="0000";
            cnt<=0;
            
        when others =>   
        
    end case;
    if (rising_edge(clk) and cnt=4) then
        display_time <=display_time+10;
    end if;
    if (rising_edge(clk) and cnt=3) then
        display_time <=display_time+10;
    end if;
    if (rising_edge(clk) and cnt=2) then
        display_time <=display_time+10;
    end if;
    if (rising_edge(clk) and cnt=1) then
        display_time <=display_time+10;
    end if;
    if(cnt=0) then
        display_time <=0;
    end if;
    if(display_time>500) then
       -- Display_1<="0000";
       -- Display_2<="0000";
       -- Display_3<="0000";
       -- Display_4<="0000";
        internal_Display_1<="0000";
        internal_Display_2<="0000";
        internal_Display_3<="0000";
        internal_Display_4<="0000";
        cnt<=0;
        reset_disp<='1';
        display_time<=0;
    end if;   
    --if (cnt >=4) then         --P�episovat ��slice bez resetu
      --     cnt<=0;
    --end if;
    --Relay Control
    if (internal2_Display_1 = internal2_Passcode_1 and internal2_Display_2 = internal2_Passcode_2 and internal2_Display_3 = internal2_Passcode_3 and internal2_Display_4 = internal2_Passcode_4) then
               Relay_o <= '1';
            else
                Relay_o <= '0';
            end if;     
            
   --HEX7SEQ                                                                                                       
   case internal2_Display_1 is
            when "0000" =>
                seg_o <= "0000001";     --0
            when "0001" =>
                seg_o <= "1001111";     --1
            when "0010" =>
                seg_o <= "0010010";     --2  
            when "0011" =>
                seg_o <= "0000110";     --3
            when "0100" =>
                seg_o <= "1001100";     --4
            when "0101" =>
                seg_o <= "0100100";     --5
            when "0110" =>
                seg_o <= "0100000";     --6
            when "0111" =>
                seg_o <= "0001111";     --7
            when "1000" =>
                seg_o <= "0000000";     --8
            when "1001" =>
                seg_o <= "0000100";     --9
            when "1010" =>
                seg_o <= "0001000";     --A
            when "1011" =>
                seg_o <= "1100000";     --B
            when "1100" =>
                seg_o <= "0110001";     --C
            when "1101" =>
                seg_o <= "1000010";     --D   
            when "1110" =>
                seg_o <= "0110000";     --E
            when others =>
                seg_o <= "0111000";     --F
        end case;
        
        case internal2_Display_2 is
            when "0000" =>
                seg_2_o <= "0000001";     --0
            when "0001" =>
                seg_2_o <= "1001111";     --1
            when "0010" =>
                seg_2_o <= "0010010";     --2  
            when "0011" =>
                seg_2_o <= "0000110";     --3
            when "0100" =>
                seg_2_o <= "1001100";     --4
            when "0101" =>
                seg_2_o <= "0100100";     --5
            when "0110" =>
                seg_2_o <= "0100000";     --6
            when "0111" =>
                seg_2_o <= "0001111";     --7
            when "1000" =>
                seg_2_o <= "0000000";     --8
            when "1001" =>
                seg_2_o <= "0000100";     --9
            when "1010" =>
                seg_2_o <= "0001000";     --A
            when "1011" =>
                seg_2_o <= "1100000";     --B
            when "1100" =>
                seg_2_o <= "0110001";     --C
            when "1101" =>
                seg_2_o <= "1000010";     --D   
            when "1110" =>
                seg_2_o <= "0110000";     --E
            when others =>
                seg_2_o <= "0111000";     --F
        end case;
        
        case internal2_Display_3 is
            when "0000" =>
                seg_3_o <= "0000001";     --0
            when "0001" =>
                seg_3_o <= "1001111";     --1
            when "0010" =>
                seg_3_o <= "0010010";     --2  
            when "0011" =>
                seg_3_o <= "0000110";     --3
            when "0100" =>
                seg_3_o <= "1001100";     --4
            when "0101" =>
                seg_3_o <= "0100100";     --5
            when "0110" =>
                seg_3_o <= "0100000";     --6
            when "0111" =>
                seg_3_o <= "0001111";     --7
            when "1000" =>
                seg_3_o <= "0000000";     --8
            when "1001" =>
                seg_3_o <= "0000100";     --9
            when "1010" =>
                seg_3_o <= "0001000";     --A
            when "1011" =>
                seg_3_o <= "1100000";     --B
            when "1100" =>
                seg_3_o <= "0110001";     --C
            when "1101" =>
                seg_3_o <= "1000010";     --D   
            when "1110" =>
                seg_3_o <= "0110000";     --E
            when others =>
                seg_3_o <= "0111000";     --F
        end case;
        
        case internal2_Display_4 is
            when "0000" =>
                seg_4_o <= "0000001";     --0
            when "0001" =>
                seg_4_o <= "1001111";     --1
            when "0010" =>
                seg_4_o <= "0010010";     --2  
            when "0011" =>
                seg_4_o <= "0000110";     --3
            when "0100" =>
                seg_4_o <= "1001100";     --4
            when "0101" =>
                seg_4_o <= "0100100";     --5
            when "0110" =>
                seg_4_o <= "0100000";     --6
            when "0111" =>
                seg_4_o <= "0001111";     --7
            when "1000" =>
                seg_4_o <= "0000000";     --8
            when "1001" =>
                seg_4_o <= "0000100";     --9
            when "1010" =>
                seg_4_o <= "0001000";     --A
            when "1011" =>
                seg_4_o <= "1100000";     --B
            when "1100" =>
                seg_4_o <= "0110001";     --C
            when "1101" =>
                seg_4_o <= "1000010";     --D   
            when "1110" =>
                seg_4_o <= "0110000";     --E
            when others =>
                seg_4_o <= "0111000";     --F
        end case;
end process p_display_control;
end Behavioral;
