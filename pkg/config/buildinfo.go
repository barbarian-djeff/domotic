package config

import (
	log "github.com/sirupsen/logrus"
)

var (
	buildTime, gitRevision, gitBranch, version string
)

func PrintBuildInfo() {
	log.Printf("Start domo-server: %s, %s, %s, %s\n", buildTime, gitRevision, gitBranch, version)
}
