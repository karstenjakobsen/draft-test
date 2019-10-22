run:
	go run -race src/*.go

all: prep binaries

prep:
	mkdir -p bin

binaries: linux64 darwin64

build:
	go build src/*.go

linux64:
	GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o bin/draft-test src/*.go

darwin64:
	GOOS=darwin GOARCH=amd64 go build -ldflags="-s -w" -o bin/draft-testOSX src/*.go
