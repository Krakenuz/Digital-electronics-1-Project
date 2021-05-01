# Systém zámku dverí

## Členové týmu
Jurek Martin, Kadlec Jiří, Kislerová Helena, Kovaříková Hana, Kratochvil Tomáš.

[Link to your GitHub project folder](https://github.com/Krakenuz/Digital-electronics-1-Project)

## Zadání projektu
Cílem projektu bylo vytvořit systém, který nám umožní zamykání a odemykání dveří pomocí pomocí 4-místného PIN kódu. V zadání bylo uedené, že pří zpracování tohoto projektu máme použít 4x3tlačítek, čtyři 7-segmentové displaye a relé, kterým budeme ovládat zámek dveří. 

## Popis hardwaru
#### Základní deska :
Jako základní desku jsme zvolili Arty A7-100T, protože ...  Využili jsme na něj porty ...

![doska](/Images/board.jpg)

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

Relé :

## Popis projektu
Vytvořili jsme projekt, ktorý pracuje na...
Při tvorbě jsme použili modul ze cvičení 4.

## Vylepšení
Přidali jsme vylepšení ...
Vylepšení, které by se ještě daly přidat jsou ...

## Plošný spoj a jeho schéma
//Krátky popis k plošáku a schéma

## Schéma zapojení projektu
Obrázek schématu zapojení projektu

## Stavový diagram 
...

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

### Procesy z testbenchu `tb_relay_control`
```vhdl 

```

## Screenshoty ze simulací
### screenshot 1 
#### popis screenshotu 1
![screenshot](/Images/scr1.png)
### screenshot 2
#### popis screenshotu 2
![screenshot](/Images/scr2.png)
### screesshot 3
#### popis screenshotu 3
![screenshot](/Images/scr2.png)
### ...
#### ...
![screenshot](/Images/scr4.png)

## Diskuze
Podařilo se nám vytvořit funkční zámek na pin ...

## Video
...

## Reference

