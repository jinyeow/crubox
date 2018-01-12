CC=crystal
CFLAGS=build --release
BINDIR=bin

up_or_down:
	crystal build src/up_or_down.cr --release -o bin/up_or_down --progress

.PHONY: clean

clean:
	rm -f $(BINDIR)/*
