LN := ln -sfv
MKDIR := mkdir -pv

BINDIR = $(HOME)/bin
BINARIES = $(shell find . -type f -o -type l -not -name Makefile)

.PHONY: $(BINARIES)

symlink: $(BINARIES)

$(BINARIES):
	@$(LN) $(PWD)/$@ $(BINDIR)/$@
