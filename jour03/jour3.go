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

func nouvCoord(l *list.List, c string, pred Coord) (Coord, bool) {
    ret := false
    switch c {
    case "^":
        pred.y++
    case ">":
        pred.x++
    case "<":
        pred.x--
    case "v":
        pred.y--
    }

    if !coordDansListe(l, pred) {
        l.PushFront(pred)
        ret = true
    }

    return pred, ret
}

func p_partie(file *os.File) {
    reader := bufio.NewReader(file)
    var nouvMaison bool
    var pred Coord
    pred.x = 0
    pred.y = 0
    nbMaisons := 1
    listeMaison := list.New()
    listeMaison.PushFront(pred)

    for char, _, err := reader.ReadRune(); err != io.EOF; {
        pred, nouvMaison = nouvCoord(listeMaison, string(char), pred)
        if nouvMaison {
            nbMaisons++
        }
        char, _, err = reader.ReadRune()
    }
    fmt.Printf("Il y a %d maisons déservies\n", nbMaisons)
}

func main() {
    inputFile, err := os.Open("input")
    check(err)

    p_partie(inputFile)

    inputFile.Close()
}

