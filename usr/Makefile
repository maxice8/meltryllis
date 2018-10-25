MKDIR := mkdir -pv

USRDIR = $(HOME)/usr
USRDIRS = $(shell find . -type d)

tree: $(USRDIRS)

$(USRDIRS):
	@$(MKDIR) $(USRDIR)/$@
