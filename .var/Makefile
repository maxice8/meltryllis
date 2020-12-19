LN := ln -sfvr
MKDIR := mkdir -pv

ETCDIR = $(HOME)/.var
ETCDIRS = $(shell find . -type d)
ETCFILES = $(shell find . \( -type f -o -type l \) -a -not -name Makefile)

.PHONY: $(ETCDIRS) $(ETCFILES)

symlink: $(ETCDIRS) $(ETCFILES)

$(ETCDIRS):
	@$(MKDIR) $(ETCDIR)
	@$(MKDIR) $(ETCDIR)/$@

$(ETCFILES):
	@$(LN) $(PWD)/$@ $(ETCDIR)/$@
