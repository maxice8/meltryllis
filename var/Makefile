MKDIR := mkdir -pv

VARDIR = $(HOME)/var
VARDIRS = $(shell find . -type d)

.PHONY: $(VARDIRS)

$(VARDIRS):
	@$(MKDIR) $(VARDIR)
	@$(MKDIR) $(VARDIR)/$@
