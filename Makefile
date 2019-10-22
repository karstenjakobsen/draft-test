VERSION ?= "v1.1.0"
run:
	go run -race src/*.go

all: prep binaries docker

prep:
	mkdir -p bin

binaries: linux64 darwin64

build:
	go build src/*.go

linux64:
	GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o bin/draft-test src/*.go

darwin64:
	GOOS=darwin GOARCH=amd64 go build -ldflags="-s -w" -o bin/draft-testOSX src/*.go

pack-linux64: linux64
	upx --brute bin/draft-test64

pack-darwin64: darwin64
	upx --brute bin/draft-testOSX

docker: pack-linux64
	docker build --build-arg version="$(VERSION)" -t karstenjakobsen/draft-test:latest . && \
	docker build --build-arg version="$(VERSION)" -t karstenjakobsen/draft-test:"$(VERSION)" .

docker-run:
	docker run pasientskyhosting/draft-test:"$(VERSION)"

docker-push: docker
	docker push pasientskyhosting/draft-test:"$(VERSION)"