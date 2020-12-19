LN := ln -sfvr
MKDIR := mkdir -pv

DOTFILES = profile
SUBDIRS = .config bin usr .local .var

.PHONY: $(DOTFILES) $(SUBDIRS)

all: symlink subdirs

symlink: $(DOTFILES)

subdirs: $(SUBDIRS)

$(SUBDIRS):
	cd $@ && $(MAKE)

$(DOTFILES):
	@$(LN) $(PWD)/$@ $(HOME)/.$@
