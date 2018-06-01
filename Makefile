LN := ln -sfv
MKDIR := mkdir -pv

DOTFILES = profile
SUBDIRS = etc bin

.PHONY: $(DOTFILES) $(SUBDIRS)

all: symlink subdirs

symlink: $(DOTFILES)

subdirs: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@ symlink

$(DOTFILES):
	@$(LN) $(PWD)/$@ $(HOME)/.$@
