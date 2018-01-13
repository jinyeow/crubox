CC=crystal build
CFLAGS=--release --progress
BINDIR=bin
PATHDIR=${HOME}/.bin

all: up_or_down netgeo copy

up_or_down: ## Check if website is up or down
				$(CC) $(CFLAGS) src/up_or_down.cr -o $(BINDIR)/up_or_down

netgeo: ## IP and Geo data
				$(CC) $(CFLAGS) src/netgeo.cr -o $(BINDIR)/netgeo

clean: ## Remove executables in bin/
				rm -f $(BINDIR)/*

copy: ## Copies executables from bin/ to $HOME/.bin
				mkdir -p $(PATHDIR)
				cp $(BINDIR)/up_or_down $(PATHDIR)
				cp $(BINDIR)/netgeo $(PATHDIR)

.PHONY: all clean copy

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
