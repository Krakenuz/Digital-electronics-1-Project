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
| 000000000001 | 0 |
| 000000000010 | 1 |
| 000000000100 | 2 |
| 000000001000 | 3 |
| 000000010000 | 4 |
| 000000100000 | 5 |
| 000001000000 | 6 |
| 000010000000 | 7 |
| 000100000000 | 8 |
| 001000000000 | 9 |
| 010000000000 | reset |

Displaye :
| vstup | Button |
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
```vhdl ```

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

