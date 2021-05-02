# Systém zámku dveří

## Členové týmu
Jurek Martin, Kadlec Jiří, Kislerová Helena, Kovaříková Hana, Kratochvil Tomáš.

[Link to your GitHub project folder](https://github.com/Krakenuz/Digital-electronics-1-Project)

## Zadání projektu
Cílem projektu bylo vytvořit systém, který nám umožní zamykání a odemykání dveří pomocí pomocí 4-místného PIN kódu. V zadání bylo uedené, že pří zpracování tohoto projektu máme použít 4x3tlačítek, čtyři 7-segmentové displaye a relé, kterým budeme ovládat zámek dveří. 

## Popis hardwaru
#### Základní deska :
Jako základní desku jsme zvolili Arty A7-100T, protože ...  
Využili jsme na něj porty ...

![deska](/Images/board.jpg)

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

#### Tabulka výstupov :
| porty | TOP výstup |
|  :-: | :-: | 
| seg_o | ja|
| seg_2_o | jb |
| seg_3_o | jc |
| seg_4_o | jd|
| relay_0 | ck_io12 |

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

#### Displaye (hex_7seg) :
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
| VSTUP | AKCE|
|  :-: | :-: | 
| 0 | ROZEPNUTO |
| 1 | SEPNUTO |
## Popis projektu
Deska reaguje na stisknutí tlačítek. Při prvím stisknutí tlačítka se nastavuje číselná hodnota na první displej, při následujícím stisknutí se nastavuje hodnota na druhý displej a stejně tak u následujících dvou displejů. Pokud jsme se překlepli pří zadávání hesla, použijeme tlačítko RESET, které slouží k vynulování všech 4 displejů najednou.
První nastavení hesla se provádí zadáním 4 číslic a následným stiskem tlačítka SET. Následně se změna hesla provádí takto: zadáme staré hesla na displej, stiskneme SET, zadáme nové heslo a následně stiskneme zase SET. Tímto jsme nastavili nové heslo. 
Když se zadá 4 místné heslo na displej, tak se sepne relé (Odemknou dveře). 
Další funkcí je automatické nulování displeje po časovém intervalu. Takže například po otevření dveří se displej automaticky za X sekund vynuluje.  
Při tvorbě jsme použili modul HEX7SEG ze cvičení 4.

## Vylepšení
Přidali jsme vylepšení ...
Vylepšení, které by se ještě daly přidat jsou ...

## Plošný spoj a jeho schéma

![schema_pcb](/Images/PCB_Schema.png)

![deska_pcb](/Images/PCB_Deska.png)


## Schéma zapojení modulov
![schema_modul](/Images/modul_schema_opravene.png)

## Stavový diagram 
????

## VHDL moduly
### Princip `relay_control`
```vhdl 
	--Relay Control
    --Sepne relé, když se číslice na displeji = heslu.
    if (s_internal2_Display_1 = s_internal2_Passcode_1 and s_internal2_Display_2 = s_internal2_Passcode_2 and s_internal2_Display_3 = s_internal2_Passcode_3 and s_internal2_Display_4 = s_internal2_Passcode_4) then
               Relay_o <= '1';
            else
                Relay_o <= '0';
            end if;     
```

### Princip `hex_7seg`
```vhdl
	--Překládá signál v binárním tvaru(0000 = číslice 0 na 7 segmentový displej) do signálu pro 7 segmentové displeje
	case s_internal2_Display_1 is
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
        
        case s_internal2_Display_2 is
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
        
        case s_internal2_Display_3 is
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
        
        case s_internal2_Display_4 is
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
```

### Architektura a porty `door_lock_system`
```vhdl 

```

### Princip `display_control`
```vhdl
		
	p_display_control: process(clk,Button_0_i,Button_1_i,Button_2_i,Button_3_i,Button_4_i,Button_5_i,Button_6_i,Button_7_i,Button_8_i,Button_9_i,Button_RESET_i,Button_SET_i,s_cnt,s_Buttons,display_time,s_reset_cnt)
begin 
	--Převedu vstupy tlačítek do 1 vektoru
    s_Buttons(0) <= Button_0_i;
    s_Buttons(1) <= Button_1_i;
    s_Buttons(2) <= Button_2_i;
    s_Buttons(3) <= Button_3_i;
    s_Buttons(4) <= Button_4_i;
    s_Buttons(5) <= Button_5_i;
    s_Buttons(6) <= Button_6_i;
    s_Buttons(7) <= Button_7_i;
    s_Buttons(8) <= Button_8_i;
    s_Buttons(9) <= Button_9_i;
    s_Buttons(10) <= Button_RESET_i;
    s_Buttons(11) <= Button_SET_i;
	
	--Při stisku tlačítka (číslice) se připočítává k s_cnt 1. s_cnt nám udává jaký displej se zrovna nastavuje.
	--Když s_cnt=1 nastavuje se 1. displej, s_cnt =4 nastavuje se hodnota na čtvrtý displej.
    if (rising_edge(Button_0_i) or rising_edge(Button_1_i)or rising_edge(Button_2_i)or rising_edge(Button_3_i)or rising_edge(Button_4_i)or rising_edge(Button_5_i)or rising_edge(Button_6_i)or rising_edge(Button_7_i)or rising_edge(Button_8_i)or rising_edge(Button_9_i)) then
        if s_cnt<4 then
        s_cnt <=s_cnt+1;
        end if;
    end if;
	--Tlačítko SET slouží pro změnu hesla. 
    if(rising_edge(Button_SET_i)) then
			--Pokud ještě heslo není nastaveno (první spuštění) nastaví se nové heslo na aktuální číslice na displeji. 
            if (s_internal_Passcode_1 ="UUUU") then
             
                s_internal_Passcode_1 <= s_internal_Display_1;
                s_internal_Passcode_2 <= s_internal_Display_2;
                s_internal_Passcode_3 <= s_internal_Display_3;
                s_internal_Passcode_4 <= s_internal_Display_4;
                s_set_disp<='1';
            else
			--Když už je heslo nastaveno na nějakou hodnotu. Zkontrolujeme, jestli se heslo rovná heslu na displeji. Pokud ano, vynulujeme displej a můžeme nastavit nové heslo.
			--Označení stavu, že se nastavuje nové heslo docílíme pomocí nastavení signálu s_set_password na true
            if (s_internal_Display_1 = s_internal_Passcode_1 and s_internal_Display_2 = s_internal_Passcode_2 and s_internal_Display_3 = s_internal_Passcode_3 and s_internal_Display_4 = s_internal_Passcode_4) then
                --Vynulování displaye před nastavením nového hesla
               
                s_internal_Display_1<="0000";
                s_internal_Display_2<="0000";
                s_internal_Display_3<="0000";
                s_internal_Display_4<="0000";
                
                s_reset_cnt<='1';
                s_reset_disp<='1';
                --nastavení nového hesla
                s_set_password<=true;
            else
			--Pokud je s_set_password true. Nastavíme nové heslo na aktuálně zadanou hodnotu na displejích. 
            if (s_set_password=true) then
               
                s_internal_Passcode_1 <= s_internal_Display_1;
                s_internal_Passcode_2 <= s_internal_Display_2;
                s_internal_Passcode_3 <= s_internal_Display_3;
                s_internal_Passcode_4 <= s_internal_Display_4;
                
                s_set_disp<='1';
                s_set_password<=false;
            end if;
            end if;
            end if;
            end if;
	--RESET pro pořadík displeje		
    if(s_reset_cnt='1') then
    s_cnt<=0;
    s_reset_cnt<='0';
    end if;
	--RESET displeje (vynulování)
    if(s_reset_disp='1') then
        s_internal2_Display_1<="0000";
        s_internal2_Display_2<="0000";
        s_internal2_Display_3<="0000";
        s_internal2_Display_4<="0000";
    s_reset_disp<='0';
    end if; 
	--SET pro nastavení hesla na číslice z displeje
    if(s_set_disp='1') then
        s_internal2_Passcode_1 <= s_internal2_Display_1;
        s_internal2_Passcode_2 <= s_internal2_Display_2;
        s_internal2_Passcode_3 <= s_internal2_Display_3;
        s_internal2_Passcode_4 <= s_internal2_Display_4;
    s_set_disp<='0';
    end if; 
	
	--CASE, který nastavuje hodnoty na displeje. Používá k tomu s_cnt. Pomocí s_cnt ví, kolikátý displej v pořadí má nastavit.
	
    case s_Buttons is
        when "000000000001" =>  --0, Bylo stisknuto tlačítko 0
            case s_cnt is
                when 1 =>	--Když s_cnt =1 , nastavuju číslici na 1. displej
                   -- Display_1<="0000";
                    s_internal_Display_1<="0000";
                    s_s_internal2_Display_1<="0000";
                when 2 =>	--Když s_cnt =2 , nastavuju číslici na 2. displej
                   -- Display_2<="0000";
                    s_internal_Display_2<="0000";
                    s_internal2_Display_2<="0000";
                when 3 =>	--Když s_cnt =3 , nastavuju číslici na 3. displej
                   -- Display_3<="0000";
                    s_internal_Display_3<="0000";
                    s_internal2_Display_3<="0000";
                when 4 =>	--Když s_cnt =4 , nastavuju číslici na 4. displej
                   -- Display_4<="0000";
                    s_internal_Display_4<="0000";
                    s_internal2_Display_4<="0000";
                when others =>    
            end case;
        when "000000000010" => --1
            case s_cnt is
                when 1 =>
                   -- Display_1<="0001";
                    s_internal_Display_1<="0001";
                    s_internal2_Display_1<="0001";
                when 2 =>
                   -- Display_2<="0001";
                    s_internal_Display_2<="0001";
                    s_internal2_Display_2<="0001";
                when 3 =>
                   -- Display_3<="0001";
                    s_internal_Display_3<="0001";
                    s_internal2_Display_3<="0001";
                when 4 =>
                   -- Display_4<="0001";
                    s_internal_Display_4<="0001";
                    s_internal2_Display_4<="0001";
                    when others =>   
            end case;   
        when "000000000100" =>
            case s_cnt is
                when 1 =>
                   -- Display_1<="0010";
                    s_internal_Display_1<="0010";
                    s_internal2_Display_1<="0010";
                when 2 =>
                   -- Display_2<="0010";
                    s_internal_Display_2<="0010";
                    s_internal2_Display_2<="0010";
                when 3 =>
                   -- Display_3<="0010";
                    s_internal_Display_3<="0010";
                    s_internal2_Display_3<="0010";
                when 4 =>
                   -- Display_4<="0010";
                    s_internal_Display_4<="0010";
                    s_internal2_Display_4<="0010";
                    when others =>   
            end case;   
        when "000000001000" =>
            case s_cnt is
                when 1 =>
                   -- Display_1<="0011";
                    s_internal_Display_1<="0011";
                    s_internal2_Display_1<="0011";
                when 2 =>
                   -- Display_2<="0011";
                    s_internal_Display_2<="0011";
                    s_internal2_Display_2<="0011";
                when 3 =>
                   -- Display_3<="0011";
                    s_internal_Display_3<="0011";
                    s_internal2_Display_3<="0011";
                when 4 =>
                   -- Display_4<="0011";
                    s_internal_Display_4<="0011";
                    s_internal2_Display_4<="0011";
                    when others =>   
            end case;   
        when "000000010000" =>
            case s_cnt is
                when 1 =>
                   -- Display_1<="0100";
                    s_internal_Display_1<="0100";
                    s_internal2_Display_1<="0100";
                when 2 =>
                   -- Display_2<="0100";
                    s_internal_Display_2<="0100";
                    s_internal2_Display_2<="0100";
                when 3 =>
                   -- Display_3<="0100";
                    s_internal_Display_3<="0100";
                    s_internal2_Display_3<="0100";
                when 4 =>
                   -- Display_4<="0100";
                    s_internal_Display_4<="0100";
                    s_internal2_Display_4<="0100";
                    when others =>   
            end case;   
        when "000000100000" =>
            case s_cnt is
                when 1 =>
                   -- Display_1<="0101";
                    s_internal_Display_1<="0101";
                    s_internal2_Display_1<="0101";
                when 2 =>
                   -- Display_2<="0101";
                    s_internal_Display_2<="0101";
                    s_internal2_Display_2<="0101";
                when 3 =>
                   -- Display_3<="0101";
                    s_internal_Display_3<="0101";
                    s_internal2_Display_3<="0101";
                when 4 =>
                   -- Display_4<="0101";
                    s_internal_Display_4<="0101";
                    s_internal2_Display_4<="0101";
                    when others =>   
            end case;   
        when "000001000000" =>
            case s_cnt is
                when 1 =>
                   -- Display_1<="0110";
                    s_internal_Display_1<="0110";
                    s_internal2_Display_1<="0110";
                when 2 =>
                   -- Display_2<="0110";
                    s_internal_Display_2<="0110";
                    s_internal2_Display_2<="0110";
                when 3 =>
                   -- Display_3<="0110";
                    s_internal_Display_3<="0110";
                    s_internal2_Display_3<="0110";
                when 4 =>
                   -- Display_4<="0110";
                    s_internal_Display_4<="0110";
                    s_internal2_Display_4<="0110";
                    when others =>   
            end case;   
        when "000010000000" =>
            case s_cnt is
                when 1 =>
                   -- Display_1<="0111";
                    s_internal_Display_1<="0111";
                    s_internal2_Display_1<="0111";
                when 2 =>
                   -- Display_2<="0111";
                    s_internal_Display_2<="0111";
                    s_internal2_Display_2<="0111";
                when 3 =>
                   -- Display_3<="0111";
                    s_internal_Display_3<="0111";
                    s_internal2_Display_3<="0111";
                when 4 =>
                   -- Display_4<="0111";
                    s_internal_Display_4<="0111";
                    s_internal2_Display_4<="0111";
                    when others =>   
            end case;   
        when "000100000000" =>
            case s_cnt is
                when 1 =>
                   -- Display_1<="1000";
                    s_internal_Display_1<="1000";
                    s_internal2_Display_1<="1000";
                when 2 =>
                   -- Display_2<="1000";
                    s_internal_Display_2<="1000";
                    s_internal2_Display_2<="1000";
                when 3 =>
                   -- Display_3<="1000";
                    s_internal_Display_3<="1000";
                    s_internal2_Display_3<="1000";
                when 4 =>
                   -- Display_4<="1000";
                    s_internal_Display_4<="1000";
                    s_internal2_Display_4<="1000";
                    when others =>   
            end case;   
        when "001000000000" =>
            case s_cnt is
                when 1 =>
                   -- Display_1<="1001";
                    s_internal_Display_1<="1001";
                    s_internal2_Display_1<="1001";
                when 2 =>
                   -- Display_2<="1001";
                    s_internal_Display_2<="1001";
                    s_internal2_Display_2<="1001";
                when 3 =>
                   -- Display_3<="1001";
                    s_internal_Display_3<="1001";
                    s_internal2_Display_3<="1001";
                when 4 =>
                   -- Display_4<="1001";
                    s_internal_Display_4<="1001";
                    s_internal2_Display_4<="1001";
                    when others =>   
            end case;   
        when "010000000000" =>      --RESET, resetuje displeje a pořadník s_cnt
            s_internal_Display_1<="0000";
            s_internal_Display_2<="0000";
            s_internal_Display_3<="0000";
            s_internal_Display_4<="0000";
            s_internal2_Display_1<="0000";
            s_internal2_Display_2<="0000";
            s_internal2_Display_3<="0000";
            s_internal2_Display_4<="0000";
            s_cnt<=0;
            
        when others =>   
        
    end case;
	--Počítač času, jak dlouho uplynulo od nastavení prvního displeje
    if (rising_edge(clk) and s_cnt>0) then
		s_display_time <=s_display_time+10;	--každých 10ms přidá hodnotu 10 do display_time
    end if;
	--Po vyresetování displeje se musí také vynulovat čas
    if(s_cnt=0) then
        display_time <=0;
    end if;
	--Po uplynutí nastavené doby vyresetuje displeje. Například po zadání hesla se otevřou dveře a po době X se vynuluje displej a zároveň zamknou dveře.
	-- Pro účel simulaci jsme použíli hodnotu s_display_time =500. To odpovídá době 500ms. Pro reálné použití se musí použít hodnota v řádu několika vteřin. Například 5sekund => s_display_time =5000
    if(s_display_time>500) then
       -- Display_1<="0000";
       -- Display_2<="0000";
       -- Display_3<="0000";
       -- Display_4<="0000";
        s_internal_Display_1<="0000";
        s_internal_Display_2<="0000";
        s_internal_Display_3<="0000";
        s_internal_Display_4<="0000";
        s_cnt<=0;
        s_reset_disp<='1';
        s_display_time<=0;
    end if; 
```

## TOP modul
### Architektura a porty `top` modulu
Tabulka pinu
## Testbenche
### Procesy z testbenche `tb_display_control`
```vhdl 

```

### Procesy z testbenche `tb_door_lock_system`
```vhdl 

```

### Procesy z testbenche `tb_relay_control`
```vhdl 

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
``odkaz na video

## Reference

