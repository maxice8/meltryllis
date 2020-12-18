LN := ln -sfv
MKDIR := mkdir -pv

DOTFILES = profile pam_environment
SUBDIRS = .config bin usr .local .var

.PHONY: $(DOTFILES) $(SUBDIRS)

all: symlink subdirs

symlink: $(DOTFILES)

subdirs: $(SUBDIRS)

$(SUBDIRS):
	cd $@ && $(MAKE)

$(DOTFILES):
	@$(LN) $(PWD)/$@ $(HOME)/.$@
