CC = cc
STIRP = strip
CP := cp -f
RM := rm -f
MKDIR := mkdir -p
CFLAGS = -Os -s
BINDIR = $(HOME)/bin

BINARIES = nochildren xwait

all: $(BINARIES) install clean

install:
	$(MKDIR) $(BINDIR)
	$(CP) $(BINARIES) $(BINDIR)

xwait: xwait.c
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o xwait

nochildren: nochildren.c
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o nochildren

clean:
	$(RM) $(BINARIES)
