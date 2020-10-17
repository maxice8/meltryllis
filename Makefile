LN := ln -sfv
MKDIR := mkdir -pv

DOTFILES = profile pam_environment
SUBDIRS = etc bin usr var

.PHONY: $(DOTFILES) $(SUBDIRS)

all: symlink subdirs

symlink: $(DOTFILES)

subdirs: $(SUBDIRS)

vdm:
	@grep '^\.' /etc/apk/world | print-virtual-deps | jq . > alpinelinux/virtual-deps

$(SUBDIRS):
	cd $@ && $(MAKE)

$(DOTFILES):
	@$(LN) $(PWD)/$@ $(HOME)/.$@
