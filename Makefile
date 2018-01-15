CC=crystal build
CFLAGS=--release --progress
BINDIR=bin
PATHDIR=${HOME}/.bin

GCC=gcc
CDIR=src/crubox/c

all: up_or_down lan netgeo copy

up_or_down: ## Check if website is up or down
	$(CC) $(CFLAGS) src/up_or_down.cr -o $(BINDIR)/up_or_down

netgeo: ## IP and Geo data
	$(CC) $(CFLAGS) src/netgeo.cr -o $(BINDIR)/netgeo

lan:
	$(GCC) -c $(CDIR)/lan.c -o $(CDIR)/lan.o

sentinel:
	$(CC) $(CFLAGS) src/sentinel.cr -o $(BINDIR)/sentinel

clean: ## Remove executables in bin/
	rm -f $(BINDIR)/*

copy: ## Copies executables from bin/ to $HOME/.bin
	mkdir -p $(PATHDIR)
	cp $(BINDIR)/* $(PATHDIR)

clearscreen:
	clear

fresh: clean clearscreen all

.PHONY: all clean copy clearscreen fresh

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help
