.ONESHELL:

SRC := $(wildcard src/*.bas)
PRG := $(patsubst src/%.bas,prg/%.prg,$(SRC))
D64 := $(patsubst src/%.bas,d64/%.d64,$(SRC))

all: $(D64)

$(PRG): prg/%.prg: src/%.bas
	petcat -v -w2 -o $@ -- $<

$(D64): d64/%.d64: prg/%.prg
	FILENAME=$(patsubst d64/%.d64,%,$@)
	cc1541 -n $$FILENAME -f $$FILENAME -w $< $@

clean:
	rm -f $(PRG) $(D64)
