LN := ln -sfv
MKDIR := mkdir -pv

DOTFILES = profile pam_environment
SUBDIRS = etc bin usr var

.PHONY: $(DOTFILES) $(SUBDIRS)

all: symlink subdirs

symlink: $(DOTFILES)

subdirs: $(SUBDIRS)

vdm:
	@grep '^\.' /etc/apk/world | print-virtual-deps | yq r --tojson - | jq . | yq r -P - > alpinelinux/virtual-deps.yaml

fdm:
	@./gen-fdm > alpinelinux/flatpaks.yaml

$(SUBDIRS):
	cd $@ && $(MAKE)

$(DOTFILES):
	@$(LN) $(PWD)/$@ $(HOME)/.$@
