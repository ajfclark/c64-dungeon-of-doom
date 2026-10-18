.ONESHELL:

SRC := $(wildcard src/*.bas)
PRG := $(SRC:src/%.bas=prg/%.prg)
TAP := $(SRC:src/%.bas=tapes/%.tap)
D64 := dungeon-of-doom.d64

CMDWRITE := $(foreach FILE,$(PRG),$(FILE:%=-write % $(FILE:prg/%.prg=%)))

all: prg d64

prg: $(PRG)
d64: $(D64)
tap: $(TAP)

$(PRG): prg/%.prg: src/%.bas
	petcat -v -w2 -o $@ -- $<

$(D64): $(PRG)
	c1541 -format "dungeon of doom,0" d64 $@ \
		$(CMDWRITE) \
		-list

$(TAP): tapes/%.tap: prg/%.prg
	prg2tap $< $@

clean:
	rm -f $(PRG) $(D64) $(TAP)
