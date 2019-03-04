package config

import "fmt"

var (
	buildTime, gitRevision, gitBranch, version string
)

func PrintBuildInfo() {
	fmt.Printf("Start domo-server: %s, %s, %s, %s\n", buildTime, gitRevision, gitBranch, version)
}
