ASM = 64tass
ASMFLAGS = -Wall -a -I $(HOME)/Devel/c128-lib --cbm-prg
EMU = $(HOME)/.local/vice/bin/x128

PROGS = hello.prg hello80.prg
PROG ?= hello

all: $(PROGS)

%.prg: %.asm $(HOME)/Devel/c128-lib/macros.asm
	$(ASM) $(ASMFLAGS) -o $@ $<

run: $(PROG).prg
	$(EMU) -autostart $<

clean:
	rm -f *.prg

.PHONY: all run clean
