THEME = theme.sed

~/.nanorc: *.nanorc mixins/*.nanorc $(THEME)
	cat *.nanorc | sed -f mixins.sed | sed -f $(THEME) $(FILTER) > $@


ifeq ($(shell test -f ~/.nanotheme && echo 1),1)
  THEME = ~/.nanotheme
endif

# Disable some unsupported features if nano version is earlier than 2.2
NANOVER = $(shell nano -V | sed -n 's/^.* version \([0-9\.]*\).*/\1/p')
ifeq ($(shell printf "2.2\n$(NANOVER)" | sort -nr | head -1),2.2)
  FILTER += | sed -e '/^header/d;/^bind/d;/^unbind/d'
endif

# Remove "set undo" option if not supported
ifneq ($(shell nano -h | grep '\-\-undo' >/dev/null && echo 1),1)
  FILTER += | sed -e '/^set undo/d'
endif

# Remove "set poslog" option if not supported
ifneq ($(shell nano -h | grep '\-\-poslog' >/dev/null && echo 1),1)
  FILTER += | sed -e '/^set poslog/d'
endif

ifdef TEXT
  FILTER += | sed -e 's|^color \(bright\)\{0,1\}black|color \1$(TEXT)|'
endif

ifdef BSDREGEX
  FILTER += | sed -e 's|\\<|[[:<:]]|g;s|\\>|[[:>:]]|g'
endif


include build.mk
.PHONY: ~/.nanorc
