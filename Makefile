prefix = /usr/local
bindir = $(prefix)/bin

MKDIR = mkdir -p
INSTALL = install

install: $(DESTDIR)$(bindir)
	$(INSTALL) gh-ssh-add $(DESTDIR)$(bindir)

$(DESTDIR)$(bindir):
	$(MKDIR) "$(DESTDIR)$(bindir)"
