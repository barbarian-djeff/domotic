
.DEFAULT_GOAL := domo-server

VERSION := 0.0.1
BUILD_TIME:=$(shell date +%Y-%m-%d-%H:%M)
GIT_REVISION=`git rev-parse --short HEAD`
GIT_BRANCH=`git rev-parse --symbolic-full-name --abbrev-ref HEAD`
GIT_DIRTY=`git diff-index --quiet HEAD -- || echo "✗-"`
LDFLAGS=-ldflags "-s \
	-X github.com/barbarian-djeff/domotic/pkg/config.buildTime=${BUILD_TIME} \
	-X github.com/barbarian-djeff/domotic/pkg/config.gitRevision=${GIT_DIRTY}${GIT_REVISION} \
	-X github.com/barbarian-djeff/domotic/pkg/config.gitBranch=${GIT_BRANCH} \
	-X github.com/barbarian-djeff/domotic/pkg/config.version=${VERSION}"

test:
	go test -v ./pkg/... ./cmd/...

lint:
	golint ./pkg/... ./cmd/...
	go tool vet -v ./cmd ./pkg

coverage:
	rm -Rf bin/coverage.*
	go clean -cache -testcache
	mkdir -p bin
	go test -v ./pkg/... ./cmd/... -coverprofile=bin/coverage.out
	go tool cover -html=bin/coverage.out -o bin/coverage.html
	
domo-server:
	rm -rf $(GOPATH)/bin/domo-server
	go build $(LDFLAGS) -v -i -o $(GOPATH)/bin/domo-server ./cmd/domo-server

for-raspberry-pi:
	rm -rf bin/raspberry-pi/domo-server
	GOOS=linux GOARCH=amd64 go build $(LDFLAGS) -v -i -o bin/raspberry-pi/domo-server ./cmd/domo-server
