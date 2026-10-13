.ONESHELL:

SRC := $(wildcard src/*.bas)
PRG := $(patsubst src/%.bas,%.prg,$(SRC))
D64 := $(patsubst %.prg,%.d64,$(PRG))

all: $(D64)

$(D64): %.d64: %.prg
	FILE=$(patsubst %.d64,%,$@)
	cc1541 -n $$FILE -f $$FILE -w $< $@

$(PRG): %.prg: src/%.bas
	petcat -v -w2 -o $@ -- $<

clean:
	rm -f *.prg *.d64
