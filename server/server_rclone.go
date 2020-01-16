package server

import (
	"log"
	"os/exec"
)

func (s *Server) rclone() string {
	cmd := exec.Command("sh", ".rclone.sh")
	stdoutStderr, _ := cmd.CombinedOutput()
	log.Printf(string([]byte(stdoutStderr)))
	return string([]byte(stdoutStderr))
}
