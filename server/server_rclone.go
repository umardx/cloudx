package server

import (
	"os/exec"
)

func (s *Server) rclone() string {
	cmd := exec.Command("sh", ".rclone.sh")
	go cmd.CombinedOutput()
	// if len(stdoutStderr) > 0 {
	// 	log.Printf(string([]byte(stdoutStderr)))
	// }
	// return string([]byte(stdoutStderr))
	return ""
}
