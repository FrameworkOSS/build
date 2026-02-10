package main

import (
	"fmt"

	"github.com/FrameworkOSS/feature_files"
)

func main() {
	f := files.NewFiles()
	if err := f.Open(); err != nil {
		panic(err)
	}
	defer f.Close()

	wd := f.GetWorkdir()
	fmt.Println("Workdir:", wd)
}
