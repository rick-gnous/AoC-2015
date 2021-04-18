package main

import (
    "bufio"
    "fmt"
    "io"
    "os"
    "container/list"
)

type Coord struct {
    x int
    y int
}

func check(e error) {
    if e != nil {
        panic(e)
    }
}

func coordDansListe(l *list.List, e Coord) (bool) {
    var tmp Coord
    for elem := l.Front(); elem != nil; elem = elem.Next() {
        tmp = Coord(elem.Value.(Coord))
        if tmp.x == e.x && tmp.y == e.y {
            return true
        }
    }
    return false
}

func p_partie(file *os.File) {
    reader := bufio.NewReader(file)
    var pred Coord
    pred.x = 0
    pred.y = 0
    nbMaison := 1
    listeMaison := list.New()
    listeMaison.PushFront(pred)
    char, _, err := reader.ReadRune()

    for err != io.EOF {
        switch string(char) {
        case "^":
            pred.y++
        case ">":
            pred.x++
        case "<":
            pred.x--
        case "v":
            pred.y--
        }

        if !coordDansListe(listeMaison, pred) {
            listeMaison.PushFront(pred)
            nbMaison++
        }
        char, _, err = reader.ReadRune()
    }
    fmt.Printf("Il y a %d maisons déservies\n", nbMaison)
}

func main() {
    inputFile, err := os.Open("input")
    check(err)

    p_partie(inputFile)

    inputFile.Close()
}

