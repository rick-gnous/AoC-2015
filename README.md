# AoC 2015


J’ai décidé de faire l’édition de 2015 de l’Advent of Code en utilisant un langage différent pour chaque jour. J’essaie d’utiliser au mieux le langage (par exemple, Java est orienté objet). Vous trouverez ci-dessous un tableau résumant rapidement ce dont vous avez besoin pour lancer chaque jour et plus bas encore des notes plus précises pour les différents jours.

## TLDR

Ce tableau contient les langages pour chaque jours ainsi que le compilateur, la commande pour compiler et exécuter les différents fichiers. Si vous souhaitez plus d’informations, descendez à la bonne section.

vbnc jour10.vbs
mono jour10.exe
| Jour | Langage     | Compilateur | Commande pour compil  |    Exécution    |   |
|-----:|------------:|------------:|----------------------:|----------------:|--:|
|  1   |    C        |    gcc      |      gcc jour1.c      |   ./a.out       |   |
|  2   |   Java      |    jdk 11   |       javac *.java    |  java Main      |   |
|  3   |             |             |                       |                 |   |
|  4   | Python      |             |                       |  python3 run.py |   |
|  5   | Cobol       |  gnucobol   |   cobc -x jour5.cob   |  ./jour5        |   |
|  6   |             |             |                       |                 |   |
|  7   |             |             |                       |                 |   |
|  8   |             |             |                       |                 |   |
|  9   |             |             |                       |                 |   |
|  10  |Visual Basic |   vbnc      |  vbnc jour10.vbs      | mono jour10.exe |   |
|  11  |   Lua       |             |                       |  lua jour11.lua |   |
|  12  | Node.JS     |             |                       | node jour12.js  |   |
|  13  |             |             |                       |                 |   |
|  14  | Objective-C |    gcc      |     [voir plus bas]   |   ./a.out       |   |
|  15  |             |             |                       |                 |   |
|  16  |             |             |                       |                 |   |
|  17  |             |             |                       |                 |   |
|  18  |             |             |                       |                 |   |
|  19  |             |             |                       |                 |   |
|  20  |             |             |                       |                 |   |
|  21  |             |             |                       |                 |   |
|  22  |             |             |                       |                 |   |
|  23  |             |             |                       |                 |   |
|  24  |             |             |                       |                 |   |



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

On retourne dans le passé ici avec le **Cobol**. J’ai utilisé le compilateur GNUCOBOL pour pouvoir compiler mon fichier. J’ai préféré utiliser l’ancienne syntaxe pour changer un peu ma façon de coder (et je trouve le symbole de la ligne 7 génial) sur la première partie.

```bash
# pour installer le compilateur
sudo xbps-install gnucobol gmp-devel # sur Void

# pour compiler et exécuter
cobc -x jour5.cob
./jour5
```

Il reste des messages de débugging. Si vous souhaitez les voir, il suffit de rajouter l’option `-fdebugging-line` au compilateur. **Les messages ont été supprimés.**

J’ai appris à coder en COBOL très rapidement pour ce jour. Je me suis appuyé sur [le cours de Wikiversite](https://fr.wikiversity.org/wiki/COBOL) pour les bases et aussi de [la documentation officielle GNUCOBOL](https://devdocs.io/gnu_cobol/).

En tant que développeur, je suis feignant. Voici un mini script bash pour générer les colonnes de lignes se trouvant dans le fichier : 

```bash
nb=$(wc -l jour5.cob | cut -d\  -f1)
for i in $(seq -f "%06g" $nb)
do
    sed -Ei '0,/(^\s{6}|^\s*$)/s//'$i'/' jour5.cob
done
```

Si vous souhaitez éditer le fichier, il est plus pratique de le faire sans ces nombres. Voici la commande permettant de les retirer :

```bash
sed -Ei 's/^[0-9]{6}$//g' jour5.cob # pour éviter les espaces inutiles
sed -Ei 's/^[0-9]{6}/      /g' jour5.cob
```

## Jour 6
## Jour 7
## Jour 8
## Jour 9

## Jour 10

Il faut utiliser Mono afin de pouvoir compiler et exécuter le Visual Basic qui utilise .NET.

```bash
trizen -S mono-basic mono
```

Il faut utiliser ensuite le compileur avant d’exécuter le `.exe` généré avec Mono.

```bash
vbnc jour10.vbs
mono jour10.exe
```

## Jour 11

Ce jour utilise le Lua 5.2.4. Il se lance comme en Python avec une commande sur le fichier :

```bash
lua jour11.lua
```

## Jour 12

Avant d’écrire le script Node.JS, j’ai utilisé une REGEX pour la première partie. Il suffit d’additionner les nombres du fichier ! Ça se fait très facilement en Bash. Par contre, la REGEX de la partie 2, si elle existe, est beaucoup plus complexe. J’ai préféré réécrire ma réponse à la question 1 en Node.JS, langage logique pour du JSON.

Voici la ligne bash décortiquée en script pour une meilleure compréhension :

```bash
sum=0
for i in $(grep -oE '(-)?[[:digit:]]+' input)
do 
    sum=$(($sum + $i))
done
echo $sum
```

Sinon, il suffit d’installer `node` et de lancer avec la commande suivante, aucune dépendance n’est requise : 

```bash
node jour12.js
```

## Jour 13
## Jour 14

Pour pouvoir compiler de l’Objective C avec GCC, installez les paquets `gcc-objc` et `gnustep-base-devel`. 

```bash
sudo xbps-install gcc-objc gnustep-base-devel # pour void
# Commandes pour la compilation (ne pas utiliser)
# gcc $(gnustep-config --objc-flags) jour14.m $(gnustep-config --base-libs)
# gcc -lobjc jour14.m
# gcc -lobjc -fconstant-string-class=NSConstantString jour14.m -lgnustep-base
```

La compilation se fait ensuite en 3 temps : il faut en premier faire les .o du main et de la classe `raindeer` avant de les mettre dans un seul et même fichier.

```bash
gcc -lobjc -fconstant-string-class=NSConstantString raindeer.m -lgnustep-base -c -o rain.o 
gcc -lobjc -fconstant-string-class=NSConstantString jour14.m -lgnustep-base -c -o jour.o 
gcc -lobjc -fconstant-string-class=NSConstantString troupeau.m -lgnustep-base -c -o troupeau.o 
gcc -lobjc -fconstant-string-class=NSConstantString *.o -lgnustep-base 
./a.out
```

La compréhension de ce langage a été assez longue… Très peu de ressources « potables » en ligne, j’ai compris comment le langage marchait avec StackOverflow et un ou deux sites mieux foutus que les autres. Un grand merci à la documentation d’Apple qui est un bourbier sans nom même s’ils tentent de faire un bon truc. Voici une liste des différents sites qui m’ont été utiles : 

* [Comment compiler l’Objective-C avec gcc](https://www.gc3.uzh.ch/blog/Compile_a_Objective-C_application_on_Ubuntu___40__Hobbes_instance__41__/)
* [Site regroupant des tutos basiques pour l’Objective-C](https://www.tutorialspoint.com/objective_c/index.htm)
* [Pleins d’exemples de code Objective-C](https://learnxinyminutes.com/docs/objective-c/)
* [Bases pour faire une classe](http://www.cocoadevcentral.com/d/learn_objectivec/)
* [Comment faire un constructeur](https://www.binpress.com/objective-c-object-initialization/)
* [Les options de *property*](https://dsrijan.medium.com/objective-c-properties-901e8a1f82ac)
* [Ancienne documentation de *property*](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjectiveC/Chapters/ocProperties.html)
* [Explication de *synthesize*](https://developer.apple.com/forums/thread/69075)
* [Tutoriel sur Objective-C, page sur *property*](https://www.journaldev.com/9580/classes-objects-and-methods-in-objective-c)
* [Exemples d’utilisation de NSString](https://eezytutorials.com/ios/nsstring-by-example.php)

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
* HolyC
* C++
* C#
* Pascal
* Freepascal
* Go
* Rust
* Groovy
* JS
* PHP
* Pony
* Ruby
* Pawn
* Squirrel
* Scala

## Langages non utilisées

Liste des langages devant être utiliser mais qui ne l’ont pas été. J’essai d’apporter des explications au pourquoi.

### LOLCODE

Le LOLCODE ne permet pas la manipulation de chaines de caractères ou de manière peu flexible : [post Stackoverflow](https://stackoverflow.com/questions/29762129/lolcode-string-parsing).

### Haskell

Le Haskell est un langage de logique, son foctionnement et surtout sa structure est différente des autres programmes.

### PureBasic

Compilateur propriétaire.
