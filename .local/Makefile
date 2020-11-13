MKDIR := mkdir -pv

VARDIR = $(HOME)/.local
VARDIRS = $(shell find . -type d)

.PHONY: $(VARDIRS)

$(VARDIRS):
	@$(MKDIR) $(VARDIR)
	@$(MKDIR) $(VARDIR)/$@
