package main

import (
	"github.com/barbarian-djeff/domotic/pkg/config"
	log "github.com/sirupsen/logrus"
)

func main() {
	log.SetFormatter(&log.TextFormatter{
		FullTimestamp: true,
	})
	config.PrintBuildInfo()
}
