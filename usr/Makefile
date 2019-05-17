MKDIR := mkdir -pv

USRDIR = $(HOME)/usr
USRDIRS = $(shell find . -type d)

PHONY: $(USRDIRS)

$(USRDIRS):
	@$(MKDIR) $(USRDIR)
	@$(MKDIR) $(USRDIR)/$@
