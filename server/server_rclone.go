package server

import (
	"io/ioutil"
	"log"
	"os"
	"os/exec"
	"time"
)

func (s *Server) rclone() string {
	cmd := exec.Command("sh", ".rclone.sh")
	go cmd.Start()
	time.Sleep(100 * time.Millisecond)

	rcloneStat := "./tmp/.rclone.stat"
	res := ""

	if fileExists(rcloneStat) {
		stat := readPIDFile(rcloneStat)
		res = string(stat)
	} else {
		res = string("Error reading " + rcloneStat)
		log.Printf(res)
	}
	return res
}

func readPIDFile(name string) string {
	file, err := os.Open(name)
	if err != nil {
		log.Printf(err.Error())
	}
	defer file.Close()

	res, _ := ioutil.ReadAll(file)
	return string(res)
}
