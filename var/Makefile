MKDIR := mkdir -pv

USRDIR = $(HOME)/var
USRDIRS = $(shell find . -type d)

tree: $(USRDIRS)

$(USRDIRS):
	@$(MKDIR) $(USRDIR)/$@
