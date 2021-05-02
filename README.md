# Systém zámku dveří

## Členové týmu
Jurek Martin, Kadlec Jiří, Kislerová Helena, Kovaříková Hana, Kratochvil Tomáš.

[Link to your GitHub project folder](https://github.com/Krakenuz/Digital-electronics-1-Project)

## Zadání projektu
Cílem projektu bylo vytvořit systém, který nám umožní zamykání a odemykání dveří pomocí pomocí 4-místného PIN kódu. V zadání bylo uedené, že pří zpracování tohoto projektu máme použít 4x3tlačítek, čtyři 7-segmentové displaye a relé, kterým budeme ovládat zámek dveří. 

## Popis hardwaru
#### Základní deska :
Jako základní desku jsme zvolili Arty A7-100T, protože ...  
Využili jsme na něj porty ck_io0-ck_io12 ako vstup a porty ja0-ja6, jb0-jb6, jc0-jc6, jd0-jd6 ako výstup.

![doska](/Images/board.jpg)

#### Tabulka vstupov :
| TOP vstup | porty |
|  :-: | :-: | 
| ck_io0 | Button_0 |
| ck_io1 | Button_1 |
| ck_io2 | Button_2 |
| ck_io3 | Button_3 |
| ck_io4 | Button_4 |
| ck_io5 | Button_5 |
| ck_io6 | Button_6 |
| ck_io7 | Button_7 |
| ck_io8 | Button_8 |
| ck_io9 | Button_9 |
| ck_io10 | Button_reset |
| ck_io11 | Button_set |
| ck_io11 | relay_0 |

#### Tabulka výstupov :
| porty | TOP výstup |
|  :-: | :-: | 
| seg_o | Button_0 |
| seg_2_o | Button_1 |
| seg_3_o | Button_2 |
| seg_4_o | Button_3 |

#### Tlačítka :
| vstup | Button |
|  :-: | :-: | 
| 000000000001 | Button_0 |
| 000000000010 | Button_1 |
| 000000000100 | Button_2 |
| 000000001000 | Button_3 |
| 000000010000 | Button_4 |
| 000000100000 | Button_5 |
| 000001000000 | Button_6 |
| 000010000000 | Button_7 |
| 000100000000 | Button_8 |
| 001000000000 | Button_9 |
| 010000000000 | Button_reset |

#### Displaye :
| vstup | display zobrazí|
|  :-: | :-: | 
| 0000 | 0 |
| 0001 | 1 |
| 0010 | 2 |
| 0011 | 3 |
| 0100 | 4 |
| 0101 | 5 |
| 0110 | 6 |
| 0111 | 7 |
| 1000 | 8 |
| 1001 | 9 |

## Popis projektu
Vytvořili jsme projekt, který pracuje na...
Při tvorbě jsme použili modul ze cvičení 4.

## Vylepšení
Přidali jsme vylepšení ...
Vylepšení, které by se ještě daly přidat jsou ...

## Plošný spoj a jeho schéma
Krátky popis k plošáku a schéma

## Schéma zapojení projektu
Obrázek schématu zapojení projektu

## Stavový diagram 
????

## VHDL moduly
### Architektura a porty `relay_control`
```vhdl 
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
```

### Architektura a porty `hex_7seg`
```vhdl
entity hex_7seg is
    Port ( hex_i : in std_logic_vector(4 - 1 downto 0);
           hex_2_i : in std_logic_vector(4 - 1 downto 0);
           hex_3_i : in std_logic_vector(4 - 1 downto 0);
           hex_4_i : in std_logic_vector(4 - 1 downto 0);
           seg_o : out std_logic_vector(7 - 1 downto 0);
           seg_2_o : out std_logic_vector(7 - 1 downto 0);
           seg_3_o : out std_logic_vector(7 - 1 downto 0);
           seg_4_o : out std_logic_vector(7 - 1 downto 0));
end hex_7seg;

architecture Behavioral of hex_7seg is

begin
--------------------------------------------------------------------
    -- p_7seg_decoder:
    -- A combinational process for 7-segment display (Common Anode)
    -- decoder. Any time "hex_i" is changed, the process is "executed".
    -- Output pin seg_o(6) controls segment A, seg_o(5) segment B, etc.
    --       segment A
    --        | segment B
    --        |  | segment C
    --        |  |  |   ...   segment G
    --        +-+|+-+          |
    --          |||            |
    -- seg_o = "0000001"-------+
    --------------------------------------------------------------------
    p_7seg_decoder : process(hex_i,hex_2_i,hex_3_i,hex_4_i)
    begin
        case hex_i is
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
        
        case hex_2_i is
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
        
        case hex_3_i is
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
        
        case hex_4_i is
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
    end process p_7seg_decoder;

end Behavioral;
```

### Architektura a porty `door_lock_system`
```vhdl 
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
           Relay_o=>Relay_o,
           seg_o=>seg_o,
           seg_2_o=>seg_2_o,
           seg_3_o=>seg_3_o,
           seg_4_o=>seg_4_o,
           clk=>clk
        );
        
        --relay_cnt: entity work.relay_control
            --port map (
                --Passcode_1=>internal_Passcode_1,
                --Passcode_2=>internal_Passcode_2,
                --Passcode_3=>internal_Passcode_3,
                --Passcode_4=>internal_Passcode_4,
                --Display_1=>internal2_Display_1,
                --Display_2=>internal2_Display_2,
                --Display_3=>internal2_Display_3,
                --Display_4=>internal2_Display_4,
                --Relay_o=>Relay_o
           -- ); 
        
        --hex_7seg: entity work.hex_7seg
          --  port map(
            --    hex_i=>internal3_Display_1,
              --  hex_2_i=>internal3_Display_2,
              --  hex_3_i=>internal3_Display_3,
               -- hex_4_i=>internal3_Display_4,
               -- seg_o=>seg_o,
               -- seg_2_o=>seg_2_o,
               -- seg_3_o=>seg_3_o,
               -- seg_4_o=>seg_4_o
           -- );    
    
end Behavioral;
```

### Architektura a porty `display_control`
```vhdl
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
    -- Pomocný vektor tlaèítka
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
                --Vynulování displaye pøed nastavením nového hesla
               
                internal_Display_1<="0000";
                internal_Display_2<="0000";
                internal_Display_3<="0000";
                internal_Display_4<="0000";
                
                reset_cnt<='1';
                reset_disp<='1';
                --nastavení nového hesla
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
    --if (cnt >=4) then         --Pøepisovat èíslice bez resetu
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
```

## TOP modul
### Architektura a porty `top` modulu
```vhdl 
entity top is
    Port ( --CLK
           CLK100MHZ : in STD_LOGIC;
            --Displays
           ja :out std_logic_vector(7 - 1 downto 0);
           jb :out std_logic_vector(7 - 1 downto 0);
           jc :out std_logic_vector(7 - 1 downto 0);
           jd : out std_logic_vector(7 - 1 downto 0);
           --Buttons
           ck_io0:in std_logic;
           ck_io1:in std_logic; 
           ck_io2:in std_logic; 
           ck_io3:in std_logic; 
           ck_io4:in std_logic; 
           ck_io5:in std_logic; 
           ck_io6:in std_logic; 
           ck_io7:in std_logic; 
           ck_io8:in std_logic; 
           ck_io9:in std_logic; 
           ck_io10:in std_logic; 
           ck_io11:in std_logic;
           --Relay  
           ck_io12:out std_logic     
           
    );
end top;

architecture Behavioral of top is

begin
    door_lock_system: entity work.door_lock_system
    port map(
        clk =>CLK100MHZ,
        Button_0 =>ck_io0,
        Button_1 =>ck_io1,
        Button_2 =>ck_io2,
        Button_3 =>ck_io3,
        Button_4 =>ck_io4,
        Button_5 =>ck_io5,
        Button_6 =>ck_io6,
        Button_7 =>ck_io7,
        Button_8 =>ck_io8,
        Button_9 =>ck_io9,
        Button_RESET =>ck_io10,
        Button_SET =>ck_io11,
        Relay_o =>ck_io12,
        seg_o(0) =>ja(0),
        seg_o(1) =>ja(1),
        seg_o(2) =>ja(2),
        seg_o(3) =>ja(3),
        seg_o(4) =>ja(4),
        seg_o(5) =>ja(5),
        seg_o(6) =>ja(6),
        seg_2_o(0) =>jb(0),
        seg_2_o(1) =>jb(1),
        seg_2_o(2) =>jb(2),
        seg_2_o(3) =>jb(3),
        seg_2_o(4) =>jb(4),
        seg_2_o(5) =>jb(5),
        seg_2_o(6) =>jb(6),
        seg_3_o(0) =>jc(0),
        seg_3_o(1) =>jc(1),
        seg_3_o(2) =>jc(2),
        seg_3_o(3) =>jc(3),
        seg_3_o(4) =>jc(4),
        seg_3_o(5) =>jc(5),
        seg_3_o(6) =>jc(6),
        seg_4_o(0) =>jd(0),
        seg_4_o(1) =>jd(1),
        seg_4_o(2) =>jd(2),
        seg_4_o(3) =>jd(3),
        seg_4_o(4) =>jd(4),
        seg_4_o(5) =>jd(5),
        seg_4_o(6) =>jd(6)
    );

end Behavioral;
```
## Testbenche
### Procesy z testbenche `tb_display_control`
```vhdl 
architecture testbench of tb_display_control is
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
    signal s_clk_100MHz : std_logic;
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
    signal s_Relay_o      : STD_LOGIC;
    signal s_seg_o :std_logic_vector(7 - 1 downto 0);
    signal s_seg_2_o :std_logic_vector(7 - 1 downto 0);
    signal s_seg_3_o :std_logic_vector(7 - 1 downto 0);
    signal s_seg_4_o :std_logic_vector(7 - 1 downto 0);


begin
	uut_display_control : entity work.display_control
        port map(
            clk     => s_clk_100MHz,
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
           Passcode_4   => s_Passcode_4,
           Relay_o      => s_Relay_o,
           seg_o        => s_seg_o,
           seg_2_o      => s_seg_2_o,
           seg_3_o      => s_seg_3_o,
           seg_4_o      => s_seg_4_o
           );
--------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 7500 ns loop         -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
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
		wait for 50ns;
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
		wait for 100ns;
		
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
		
		s_Button_RESET <= '1';
		wait for 50ns;
		s_Button_RESET <= '0';
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
```

### Procesy z testbenche `tb_door_lock_system`
```vhdl 
architecture testbench of tb_door_lock_system is
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
    signal s_clk_100MHz : std_logic;
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
    signal s_Relay_o :  STD_LOGIC;
    signal s_seg_o :  std_logic_vector(7 - 1 downto 0);
    signal s_seg_2_o :  std_logic_vector(7 - 1 downto 0);
    signal s_seg_3_o :  std_logic_vector(7 - 1 downto 0);
    signal s_seg_4_o :  std_logic_vector(7 - 1 downto 0);

begin
	uut_display_control : entity work.door_lock_system
        port map(
            clk     => s_clk_100MHz,
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
            seg_o	=>	s_seg_o,
            seg_2_o	=>	s_seg_2_o,
            seg_3_o	=>	s_seg_3_o,
            seg_4_o	=>	s_seg_4_o,
            Relay_o=> s_Relay_o
            );
           
--------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 7500 ns loop         -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
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
		wait for 50ns;
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
		wait for 100ns;
		
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
		
		s_Button_RESET <= '1';
		wait for 50ns;
		s_Button_RESET <= '0';
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
		
		--s_Button_SET <='1';
		--wait for 50ns;
		--s_Button_SET <='0';
		--wait for 10ns;
		
		
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
end testbench;
```

### Procesy z testbenche `tb_relay_control`
```vhdl 
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
```

## Screenshoty ze simulací
### screenshot 1 
popis screenshotu 1
![screenshot](/Images/scr1.png)
### screenshot 2
popis screenshotu 2
![screenshot](/Images/scr2.png)
### screenshot 3
popis screenshotu 3
![screenshot](/Images/scr3.png)
### screenshot 4
popis screenshotu 4
![screenshot](/Images/scr4.png)

## Diskuze
Podařilo se nám vytvořit funkční zámek na pin ...

## Video
odkaz na video

## Reference

