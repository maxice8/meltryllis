LN := ln -sfv
MKDIR := mkdir -pv

ETCDIR = $(XDG_CONFIG_HOME)
ETCDIRS = $(shell find . -type d)
ETCFILES = $(shell find . -type f -o -type l -not -name Makefile)

.PHONY: $(ETCDIRS) $(ETCFILES)

symlink: $(ETCDIRS) $(ETCFILES)

$(ETCDIRS):
	@$(MKDIR) $(ETCDIR)
	@$(MKDIR) $(ETCDIR)/$@

$(ETCFILES):
	@$(LN) $(PWD)/$@ $(ETCDIR)/$@
