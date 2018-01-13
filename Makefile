CC=crystal build
CFLAGS=--release --progress
BINDIR=bin

all: up_or_down netgeo

up_or_down: ## Check if website is up or down
				$(CC) $(CFLAGS) src/up_or_down.cr -o $(BINDIR)/up_or_down

netgeo: ## IP and Geo data
				$(CC) $(CFLAGS) src/netgeo.cr -o $(BINDIR)/netgeo

clean: ## Remove executables in bin/
	rm -f $(BINDIR)/*

.PHONY: clean all

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
