# Dungeon of Doom for the C64

Dungeon of Doom is a game described in the Usborne Publishing book; "Write your own fantasy games for
your microcomputer" by Les Howarth and Cheryl Evans.  In that book, the reader is encouraged to type
out the game from the source listings in the book into their own microcomputer.  Supported models
include the the Commodore 64, VIC-20, BBC Micro, Acorn Electron and the Sinclair ZX Spectrum.

In this repository, you can find the C64 version of the code for your review.  To learn more about
how to use the applications, please be sure to check out the Usborne website and download your copy
of the book for free.

* https://usborne.com/browse-books/features/computer-and-coding-books/

## How to play

Before you can explore a dungeon, you need **at least one saved dungeon level and one saved
character**. From there, you can then load the `game` program to play the game. If you need
help, I suggest you read the [docs](#docs) for help with creating characters
and levels, saving and loading tapes, game controls, and magic.

## Entering the programs

Use VICE in **C64 mode**. Start with a fresh or reset C64 for each program, then choose any
of these loading methods.

All methods start the same programs. You still need writable tape images to save your character
and dungeon and load them into the game. Initialization takes a little time; VICE's warp mode can
speed up loading, but turn it off before playing.

### Generating .prg files from .bas files

VICE ships with the `petcat` utility. This can create a tokenised c64 program file (PRG) from a BASIC listing.

To do so, run the following commands:
```
petcat -w3 -o dungeon.prg -- dungeon.bas
petcat -w3 -o character.prg -- character.bas
petcat -w3 -o game.prg -- game.bas
```

These need to be regenerated each time you update the source files.

If you have `make` installed, there's a Makefile provided that will regenerate the .prg files when the .bas files change.

### Create disk images
Back in the day AJ was lucky enough to have a 1541-II drive so he stored the programs on a single disk.

#### with c1541

VICE ships with the c1541 utility. This can create a .d64 disk image from the .prg files:
```
c1541 -format 'dungeon of doom,0' d64 d64/dungeon-of-doom.d64 \
-write prg/character.prg character \
-write prg/dungeon.prg dungeon \
-write prg/game.prg game \
-list
```

If you have `make` installed, the Makefile provided that will regenerate the .d64 image when you call the d64 target with `make d64`

### Creating tape images

#### with VICE

1. Open `character.bas` in a text editor and copy the entire listing.  Keep the source lowercase; uppercase text can become graphics characters when pasted into VICE.
2. At the C64's `READY.` prompt, choose VICE's **Edit → Paste**.  Wait for the whole listing to finish entering. If the final line is still waiting at the cursor, press **Return** to submit it.
3. Choose VICE's **File → Create and attach a dataset image**. Pick somewhere to save your tape image.
4. Type `SAVE"CHARACTER",1` into the `READY` prompt
5. When prompted to press record on tape, press record on tape in VICE's menu
6. Wait for the OK response (VICE's warp mode can help here)
7. Reset VICE

Repeat for the Dungeon Generator and Game Module as DUNGEON and GAME respectively.

#### with prg2tap

prg2tap is not part of VICE, but can be found here: https://www.luigidifraia.com/software/#PRG_to_TAP_encapsulation_utility

Using this is fairly simple:
```
prg2tap prg/character.prg tapes/character.tap
prg2tap prg/dungeon.prg tapes/dungeon.tap
prg2tap prg/game.prg tapes/game.tap
```

If you have `make` installed, the Makefile provided that will regenerate the .tap images when you call the tap target with `make tap`

## Starting the programs

### Attach the .prg files directly

1. Use VICE's **Smart attach** action to attach the appropriate .prg file.
2. VICE will issue the correct load command automatically
3. Wait for loading to finish and `READY.` to appear, then enter `RUN` and press **Return**.

### Load a disk image

1. Use VICE's **Smart attach** action to attach the appropriate .d64 file.
2. Enter the matching command at the C64's BASIC prompt and press **Return**:

   | Program | Load command |
   | --- |  --- |
   | Character creator | `LOAD"CHARACTER",8` |
   | Dungeon creator | `LOAD"DUNGEON",8` |
   | Game | `LOAD"GAME",8` |

3. Wait for loading to finish and `READY.` to appear, then enter `RUN` and press **Return**.

### Load a tape image

1. Use VICE's **Attach datasette image** action to attach the program tape.
2. Enter the matching command at the C64's BASIC prompt and press **Return**:

   | Program | Tape image | Load command |
   | --- | --- | --- |
   | Character creator | `tapes/character.tap` | `LOAD"CHARACTER",1` |
   | Dungeon creator | `tapes/dungeon.tap` | `LOAD"DUNGEON",1` |
   | Game | `tapes/game.tap` | `LOAD"GAME",1` |

3. When prompted to press Play on tape, select VICE's Datasette **Play** control.
4. Wait for loading to finish and `READY.` to appear, then enter `RUN` and press **Return**.

## Project Structure

The `tapes/` directory contains the program tape images: `character.tap`, `dungeon.tap`, and
`game.tap`. Use the `saves/` directory for your character, dungeon, and game saves. `prg/` is there for prg files. `d64/` for .d64 images.

## Cheat sheets

* [Character creator](docs/character.md)
* [Dungeon generator](docs/dungeon.md)
* [Game module](docs/game.md)
