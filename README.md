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

```

### Architektura a porty `hex_7seg`
```vhdl

```

### Architektura a porty `door_lock_system`
```vhdl 

```

### Architektura a porty `display_control`
```vhdl

```

## TOP modul
### Architektura a porty `top` modulu

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

