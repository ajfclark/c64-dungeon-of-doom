.ONESHELL:

SRC := $(wildcard src/*.bas)
PRG := $(patsubst src/%.bas,prg/%.prg,$(SRC))
TAP := $(patsubst src/%.bas,tapes/%.tap,$(SRC))
D64 := d64/dungeonofdoom.d64
FILELIST := $(foreach FILE,$(PRG),$(patsubst prg/%.prg,-f % -w $(FILE),$(FILE)))

all: prg
d64: $(D64)
tap: $(TAP)
prg: $(PRG)

$(PRG): prg/%.prg: src/%.bas
	petcat -v -w2 -o $@ -- $<

$(D64): $(PRG)
	cc1541 -n 'dungeon of doom' $(FILELIST) $@

$(TAP): tapes/%.tap: prg/%.prg
	prg2tap $< $@

clean:
	rm -f prg/*.prg d64/*.d64
