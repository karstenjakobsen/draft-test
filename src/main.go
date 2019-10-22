package main

import (
	"fmt"
	"os"
)

func main() {
	fmt.Println("hello world - I'm version ", os.Getenv("VERSION"))
}
