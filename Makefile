.PHONY: all build run clean install-agent uninstall-agent

all: build

build:
	./scripts/build-app.sh

run: build
	open "./build/Kitty Litter.app"

clean:
	rm -rf "./build/Kitty Litter.app"

install-agent: build
	./scripts/install-agent.sh

uninstall-agent:
	./scripts/uninstall-agent.sh
