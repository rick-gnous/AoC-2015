# AoC 2015

J’ai décidé de faire l’édition de 2015 de l’Advent of Code en utilisant un langage différent pour chaque jour. J’essaie d’utiliser au mieux le langage (par exemple, Java est orienté objet). Vous trouverez ci-dessous un tableau résumant rapidement ce dont vous avez besoin pour lancer chaque jour et plus bas encore des notes plus précises pour les différents jours.

## TLDR

Ce tableau contient les langages pour chaque jours ainsi que le compilateur, la commande pour compiler et exécuter les différents fichiers. Si vous souhaitez plus d’informations, descendez à la bonne section.

| Jour | Langage | Compilateur | Commande pour compil  |    Exécution    |   |
|-----:|--------:|------------:|----------------------:|----------------:|--:|
|  1   |    C    |    gcc      |      gcc jour1.c      |   ./a.out       |   |
|  2   |   Java  |    jdk 11   |       javac *.java    |  java Main      |   |
|  3   |         |             |                       |                 |   |
|  4   | Python  |             |                       |  python3 run.py |   |
|  5   | Cobol   |  gnucobol   |   cobc -x jour5.cob   |  ./jour5        |   |
|  6   |         |             |                       |                 |   |
|  7   |         |             |                       |                 |   |
|  8   |         |             |                       |                 |   |
|  9   |         |             |                       |                 |   |
|  10  |         |             |                       |                 |   |
|  11  |         |             |                       |                 |   |
|  12  |         |             |                       |                 |   |
|  13  |         |             |                       |                 |   |
|  14  |         |             |                       |                 |   |
|  15  |         |             |                       |                 |   |
|  16  |         |             |                       |                 |   |
|  17  |         |             |                       |                 |   |
|  18  |         |             |                       |                 |   |
|  19  |         |             |                       |                 |   |
|  20  |         |             |                       |                 |   |
|  21  |         |             |                       |                 |   |
|  22  |         |             |                       |                 |   |
|  23  |         |             |                       |                 |   |
|  24  |         |             |                       |                 |   |



## Jour 1

Le langage utilisé pour ce jour là est le **C**. Simple et efficace, il vous suffit d’avoir le compilateur `gcc` d’installé pour pouvoir le compiler.

```bash
gcc jour1.c
./a.out
```

## Jour 2

Ici, le langage est le **Java** et l’approche du problème s’est fait avec des classes. La compilation varie selon votre `CLASSPATH` mais voici les commandes à entrer afin de faire marcher à coup sûr la compilation.

```bash
export CLASSPATH=$CLASSPATH:../class
mkdir ws class
cd ws
javac -d ../class ../*.java
java Main
```

## Jour 3

## Jour 4

Le langage le plus simple ! Juste un fichier d’une vingtaine de ligne : merci au **Python** ! J’ai décidé de faire une approche bruteforce au lieu de chercher un moyen de « casser » le MD5. Pardonnez ma fainéantise.

```bash
python3 run.py
```

## Jour 5

On retourne dans le passé ici avec le **Cobol**. J’ai utilisé le compilateur GNUCOBOL pour pouvoir compiler mon fichier. J’ai préféré utiliser l’ancienne syntaxe pour changer un peu ma façon de coder (et je trouve le symbole de la ligne 7 génial).

```bash
# pour installer le compilateur
sudo xbps-install gnucobol gmp-devel # sur Void

# pour compiler et exécuter
cobc -x jour5.cob
./jour5
```

Il reste des messages de débugging. Si vous souhaitez les voir, il suffit de rajouter l’option `-fdebugging-line` au compilateur.

J’ai appris à coder en COBOL très rapidement pour ce jour. Je me suis appuyé sur [le cours de Wikiversite](https://fr.wikiversity.org/wiki/COBOL) pour les bases et aussi de [la documentation officielle GNUCOBOL](https://devdocs.io/gnu_cobol/).

## Jour 6
## Jour 7
## Jour 8
## Jour 9
## Jour 10
## Jour 11
## Jour 12
## Jour 13
## Jour 14
## Jour 15
## Jour 16
## Jour 17
## Jour 18
## Jour 19
## Jour 20
## Jour 21
## Jour 22
## Jour 23
## Jour 24






Liste des langages utilisés


* Shell
* Perl
* LOLCODE / HolyC
* C++
* C#
* Pascal
* Freepascal
* Go
* Rust
* Groovy
* Haskell
* JS
* PHP
* Pony
* Ruby
* Lua
* Pawn
* PureBasic
* Squirrel
* Scala
