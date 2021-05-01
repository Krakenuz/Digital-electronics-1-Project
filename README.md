# Systém zámku dverí

## Členovia tímu
Jurek Martin, Kadlec Jiří, Kislerová Helena, Kovaříková Hana, Kratochvil Tomáš.

[Link to your GitHub project folder](https://github.com/Krakenuz/Digital-electronics-1-Project)

## Zadanie projektu
Cielom projektu bolo vytvoriť systém ktorý nám umožní zamykanie a odomykanie dverí pomocou 4 miestneho PIN kódu. V zadaní bolo uvedené, že pri vyhotovení tohoto projektu máme použiť 4x3 tlačítiek, styri 7-segmentové displaye a relé, ktorým budeme ovládať zámok dverí.

## Popis hardwaru
Základná doska :


Tlačítka :
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

Displaye :
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

Relé :

## Popis projektu
Vytvorili sme projekt, ktorý robí...
Pri tvorení sme použili modul z cvičenia č. 4.

## Vylepšenia
Pridali sme vylepšenia ...

Vylepšenia, ktoré by sa ešte dali pridať sú...

## Plošný spoj a jeho schéma
Krátky popis k plošáku a schéma

## Schéma zapojenia projektu
Obrázok schémy zapojenia projektu

## Stavový diagram ?

## VHDL moduly
### architektúra a porty `relay_control`
```vhdl ```
### architektúra a porty `hex_7seg`
```vhdl ```
### architektúra a porty `door_lock_system`
```vhdl ```
### architektúra a porty `display_control`
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
    signal cnt : natural;
    signal set_password : boolean;
    signal display_time : natural;
begin
p_display_control: process(clk,Button_0,Button_1,Button_2,Button_3,Button_4,Button_5,Button_6,Button_7,Button_8,Button_9,Button_Reset,Button_SET)
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
                Passcode_1 <= internal_Display_1;
                Passcode_2 <= internal_Display_2;
                Passcode_3 <= internal_Display_3;
                Passcode_4 <= internal_Display_4;
                internal_Passcode_1 <= internal_Display_1;
                internal_Passcode_2 <= internal_Display_2;
                internal_Passcode_3 <= internal_Display_3;
                internal_Passcode_4 <= internal_Display_4;
            else
            if (internal_Display_1 = internal_Passcode_1 and internal_Display_2 = internal_Passcode_2 and internal_Display_3 = internal_Passcode_3 and internal_Display_4 = internal_Passcode_4) then
                --Vynulování displaye pøed nastavením nového hesla
                Display_1 <="0000";
                Display_2 <="0000";
                Display_3 <="0000";
                Display_4 <="0000";
                internal_Display_1<="0000";
                internal_Display_2<="0000";
                internal_Display_3<="0000";
                internal_Display_4<="0000";
                cnt<=0;
                --nastavení nového hesla
                set_password<=true;
            else
            if (set_password=true) then
                Passcode_1 <= internal_Display_1;
                Passcode_2 <= internal_Display_2;
                Passcode_3 <= internal_Display_3;
                Passcode_4 <= internal_Display_4;
                internal_Passcode_1 <= internal_Display_1;
                internal_Passcode_2 <= internal_Display_2;
                internal_Passcode_3 <= internal_Display_3;
                internal_Passcode_4 <= internal_Display_4;
                set_password<=false;
            end if;
            end if;
            end if;
            end if;
    case Buttons is
        when "000000000001" =>  --0
            case cnt is
                when 1 =>
                    Display_1<="0000";
                    internal_Display_1<="0000";
                when 2 =>
                    Display_2<="0000";
                    internal_Display_2<="0000";
                when 3 =>
                    Display_3<="0000";
                    internal_Display_3<="0000";
                when 4 =>
                    Display_4<="0000";
                    internal_Display_4<="0000";
                when others =>    
            end case;
        when "000000000010" => --1
            case cnt is
                when 1 =>
                    Display_1<="0001";
                    internal_Display_1<="0001";
                when 2 =>
                    Display_2<="0001";
                    internal_Display_2<="0001";
                when 3 =>
                    Display_3<="0001";
                    internal_Display_3<="0001";
                when 4 =>
                    Display_4<="0001";
                    internal_Display_4<="0001";
                    when others =>   
            end case;   
        when "000000000100" =>
            case cnt is
                when 1 =>
                    Display_1<="0010";
                    internal_Display_1<="0010";
                when 2 =>
                    Display_2<="0010";
                    internal_Display_2<="0010";
                when 3 =>
                    Display_3<="0010";
                    internal_Display_3<="0010";
                when 4 =>
                    Display_4<="0010";
                    internal_Display_4<="0010";
                    when others =>   
            end case;   
        when "000000001000" =>
            case cnt is
                when 1 =>
                    Display_1<="0011";
                    internal_Display_1<="0011";
                when 2 =>
                    Display_2<="0011";
                    internal_Display_2<="0011";
                when 3 =>
                    Display_3<="0011";
                    internal_Display_3<="0011";
                when 4 =>
                    Display_4<="0011";
                    internal_Display_4<="0011";
                    when others =>   
            end case;   
        when "000000010000" =>
            case cnt is
                when 1 =>
                    Display_1<="0100";
                    internal_Display_1<="0100";
                when 2 =>
                    Display_2<="0100";
                    internal_Display_2<="0100";
                when 3 =>
                    Display_3<="0100";
                    internal_Display_3<="0100";
                when 4 =>
                    Display_4<="0100";
                    internal_Display_4<="0100";
                    when others =>   
            end case;   
        when "000000100000" =>
            case cnt is
                when 1 =>
                    Display_1<="0101";
                    internal_Display_1<="0101";
                when 2 =>
                    Display_2<="0101";
                    internal_Display_2<="0101";
                when 3 =>
                    Display_3<="0101";
                    internal_Display_3<="0101";
                when 4 =>
                    Display_4<="0101";
                    internal_Display_4<="0101";
                    when others =>   
            end case;   
        when "000001000000" =>
            case cnt is
                when 1 =>
                    Display_1<="0110";
                    internal_Display_1<="0110";
                when 2 =>
                    Display_2<="0110";
                    internal_Display_2<="0110";
                when 3 =>
                    Display_3<="0110";
                    internal_Display_3<="0110";
                when 4 =>
                    Display_4<="0110";
                    internal_Display_4<="0110";
                    when others =>   
            end case;   
        when "000010000000" =>
            case cnt is
                when 1 =>
                    Display_1<="0111";
                    internal_Display_1<="0111";
                when 2 =>
                    Display_2<="0111";
                    internal_Display_2<="0111";
                when 3 =>
                    Display_3<="0111";
                    internal_Display_3<="0111";
                when 4 =>
                    Display_4<="0111";
                    internal_Display_4<="0111";
                    when others =>   
            end case;   
        when "000100000000" =>
            case cnt is
                when 1 =>
                    Display_1<="1000";
                    internal_Display_1<="1000";
                when 2 =>
                    Display_2<="1000";
                    internal_Display_2<="1000";
                when 3 =>
                    Display_3<="1000";
                    internal_Display_3<="1000";
                when 4 =>
                    Display_4<="1000";
                    internal_Display_4<="1000";
                    when others =>   
            end case;   
        when "001000000000" =>
            case cnt is
                when 1 =>
                    Display_1<="1001";
                    internal_Display_1<="1001";
                when 2 =>
                    Display_2<="1001";
                    internal_Display_2<="1001";
                when 3 =>
                    Display_3<="1001";
                    internal_Display_3<="1001";
                when 4 =>
                    Display_4<="1001";
                    internal_Display_4<="1001";
                    when others =>   
            end case;   
        when "010000000000" =>      --RESET
            Display_1<="0000";
            Display_2<="0000";
            Display_3<="0000";
            Display_4<="0000";
            internal_Display_1<="0000";
            internal_Display_2<="0000";
            internal_Display_3<="0000";
            internal_Display_4<="0000";
            cnt<=0;
            
        when others =>   
        
    end case;
    if ((rising_edge(clk) and cnt=4)or(rising_edge(clk) and cnt=1)or(rising_edge(clk) and cnt=2)or(rising_edge(clk) and cnt=3)) then
        display_time <=display_time+10;
    end if;
    if(cnt=0) then
        display_time <=0;
    end if;
    if(display_time>500) then
        Display_1<="0000";
        Display_2<="0000";
        Display_3<="0000";
        Display_4<="0000";
        internal_Display_1<="0000";
        internal_Display_2<="0000";
        internal_Display_3<="0000";
        internal_Display_4<="0000";
        cnt<=0;
        display_time<=0;
    end if;   
    --if (cnt >=4) then         --Pøepisovat èíslice bez resetu
      --     cnt<=0;
    --end if;                                                                                                       
end process p_display_control;
```

## TOP modul
### architektúra a porty `top` modulu

## Testbenche
### procesy z testbenchu `tb_display_control`
```vhdl ```
### procesy z testbenchu `tb_door_lock_system`
```vhdl ```
### procesy z testbenchu `tb_relay_control`
```vhdl ```

## Screenshoty zo simulácii
### screesshot 1 
#### popis screenshotu 1
![screenshot](/Images/scr1.png)
### screesshot 2
#### popis screenshotu 2
![screenshot](/Images/scr2.png)
### screesshot 3
#### popis screenshotu 3
![screenshot](/Images/scr2.png)
### ...
#### ...
![screenshot](/Images/scr4.png)

## Diskusia
Podarilo sa nám vytvoriť funkčný zámok dverí na pin ....

## Video
*Vložiť video*

## Referencie

