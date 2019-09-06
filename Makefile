LN := ln -sfv
MKDIR := mkdir -pv

DOTFILES = profile mailcap pam_environment
SUBDIRS = etc bin usr var

.PHONY: $(DOTFILES) $(SUBDIRS)

all: symlink subdirs

symlink: $(DOTFILES)

subdirs: $(SUBDIRS)

$(SUBDIRS):
	cd $@ && $(MAKE)

$(DOTFILES):
	@$(LN) $(PWD)/$@ $(HOME)/.$@
