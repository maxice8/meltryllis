LN := ln -sfv
MKDIR := mkdir -pv

DOTFILES = profile mailcap
SUBDIRS = etc bin usr var

.PHONY: $(DOTFILES) $(SUBDIRS)

all: symlink subdirs

symlink: $(DOTFILES)

subdirs: $(SUBDIRS)

$(SUBDIRS):
	cd $@ && $(MAKE)

$(DOTFILES):
	@$(LN) $(PWD)/$@ $(HOME)/.$@
