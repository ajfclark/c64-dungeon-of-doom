.ONESHELL:

SRC := $(wildcard src/*.bas)
PRG := $(patsubst src/%.bas,prg/%.prg,$(SRC))

all: $(PRG)

$(PRG): prg/%.prg: src/%.bas
	petcat -v -w2 -o $@ -- $<

clean:
	rm -f *.prg *.d64
