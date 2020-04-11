define INSTALL
cp $(PROGRAM) $(BINDIR)/$(PROGRAM)
chmod 755 $(BINDIR)/$(PROGRAM)
endef

define UNINSTALL
rm -f $(BINDIR)/$(PROGRAM)
endef

ifeq "$(PROGRAM)" ""
PROGRAM := $(notdir $(CURDIR))
endif
BINDIR := /home/shaw/v/bin

.PHONY:	probe check install uninstall diff dist-diff update
.PHONY: options show-targets e

probe:
	echo "BINDIR=$(BINDIR)"
	ls -dlh "$(BINDIR)/$(PROGRAM)"

check:
	perl -wc $(PROGRAM)

install: ./$(PROGRAM)
	$(INSTALL)

uninstall: ./$(PROGRAM)
	$(UNINSTALL)

diff:
	rcs-diff --diff-ok -u $(PROGRAM)

dist-diff:
	dist-diff $(PROGRAM)

update:
	rcs-update --create $(PROGRAM)

options:
	sed -n -e '/options = (/,/);/p' $(PROGRAM)

show-targets:
	@show-makefile-targets

show-%:
	@echo $*=$($*)

e:
	psdk-vim $(PROGRAM)

#END
