CC = cc
STIRP = strip
CP := cp -f
RM := rm -f
MKDIR := mkdir -p
CFLAGS = -Os -s
BINDIR = $(HOME)/bin

BINARIES = nochildren xwait

ifeq ($(shell pkg-config --exists gnome-keyring-1; echo $?),0)
	BINARIES = $(BINARIES) lock-keyring
endif

all: $(BINARIES) install clean

install:
	$(MKDIR) $(BINDIR)
	$(CP) $(BINARIES) $(BINDIR)

lock-keyring: lock-keyring.c
	$(CC) $(CFLAGS) $(LDFLAGS) lock-keyring.c -o lock-keyring $(shell pkg-config gnome-keyring-1 --cflags --libs)

xwait: xwait.c
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o xwait

nochildren: nochildren.c
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o nochildren

clean:
	$(RM) $(BINARIES)
