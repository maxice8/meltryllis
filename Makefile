LN := ln -sfvr
MKDIR := mkdir -pv

SUBDIRS = .config bin usr .local

.PHONY: $(SUBDIRS)

all: subdirs

subdirs: $(SUBDIRS)

$(SUBDIRS):
	cd $@ && $(MAKE)
