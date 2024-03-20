package main

import (
	"github.com/graemenewlands/go-cuda-helloworld/pkg/cudahello"
	"fmt"
)

func main() {
    v := aslex.GPURedux(1024)
    fmt.Println("got: ", v)
	// fmt.Println("boo")
}
