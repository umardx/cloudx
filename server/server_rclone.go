package server

import (
	"log"
	"os/exec"
)

func (s *Server) rclone() string {

	if execRclone() {
		return "Rclone go running"
	}
	return "Something wrong"
}

func execRclone() bool {
	cmd := exec.Command("sh", ".rclone.sh")
	stdoutStderr, _ := cmd.CombinedOutput()
	log.Printf(string([]byte(stdoutStderr)))
	return true
}
