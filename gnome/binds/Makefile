DCONF ?= $(shell command -v dconf)

.PHONY: usage

usage:
	$(error run either 'make dump' or 'make load' to dump the bindings or load them)

check-dconf:
ifeq ($(strip $(DCONF)),)
	$(error dconf was not founnd please pass DCONF=/path/to/dconf)
else
	$(info found dconf in $(DCONF))
endif

dump: check-dconf
	$(info dumping /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings into 'custom-bindings')
	@$(DCONF) dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > custom-bindings
	$(info dumped /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings into 'custom-bindings')

load: check-dconf
	$(info loading /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings from 'custom-bindings')
	@$(DCONF) load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ < custom-bindings
	$(info loaded /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings from 'custom-bindings')
