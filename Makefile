.ONESHELL:

SRC := $(wildcard src/*.bas)
PRG := $(patsubst src/%.bas,prg/%.prg,$(SRC))
D64 := d64/dungeonofdoom.d64
FILELIST := $(foreach FILE,$(PRG),$(patsubst prg/%.prg,-f % -w $(FILE),$(FILE)))

all: prg
d64: $(D64)
prg: $(PRG)

$(PRG): prg/%.prg: src/%.bas
	petcat -v -w2 -o $@ -- $<

$(D64): $(PRG)
	cc1541 -n 'dungeon of doom' $(FILELIST) $@

clean:
	rm -f prg/*.prg d64/*.d64
