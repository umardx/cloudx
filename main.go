package main

import (
	"errors"
	"log"
	"os"

	"github.com/jpillora/opts"
	"github.com/umardx/cloudx/server"
)

var VERSION = "0.0.0-src" //set with ldflags

func main() {
	s := server.Server{
		Title: "Cloud X Torrent",
		Port:  80,
	}

	o := opts.New(&s)
	o.Version(VERSION)
	o.Repo("https://github.com/umardx/cloudx")
	o.PkgRepo()
	o.SetLineWidth(96)
	o.Parse()

	if s.DisableLogTime {
		log.SetFlags(0)
	}

	log.Printf("############# Cloud X Torrent ver[%s] #############\n", VERSION)
	if err := s.Run(VERSION); err != nil {
		if errors.Is(err, server.ErrDiskSpace) {
			log.Println(err)
			os.Exit(42)
		}
		log.Fatal(err)
	}
}
