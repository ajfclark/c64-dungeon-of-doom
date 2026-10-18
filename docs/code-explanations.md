
==== The 5000 lines ====

From https://www.lemon64.com/forum/viewtopic.php?t=66988
5000: those pokes go to the high bytes of the respective pointers. The second poke sets the string heap's top address to $8000 to make room for screen ram there and a copy of the rom charset in the ram above.

The first one doesn't seem to make any sense though as it sets the bottom of the string heap to $8000+something, leaving basically no room for strings at all.

5010: stop CIA1 timer A to prevent interrupts, then bank out the I/O area so that the character rom can be accessed by the cpu.

5020: copies the character rom contents to $8800, so that we can then modify them for the custom characters

5030: then bank in the I/O area at $d000-$dfff again so that VIC, SID and CIA-chips can be accessed again. This is required for the interrupt service routine (which scans the keyboard, updates TI etc.) to work.

5040: starts timer A of CIA1 again, which triggers the above-mentioned interrupt service routine ca. 60 times a second.

5050: sets the corresponding bits of CIA 2 data port A to output. Those are the bits that control which of the 4 16K video banks the VIC chip can see.

5060: Clear bit 0, set bit 1 of $DD00, thus VIC Bank #2 $8000-$bfff is active

5070: set up VIC to see screen memory at $8000 and charset at $8800 (where the rom charset was copied to in line 5020).

