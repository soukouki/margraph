
RUBY = ruby

SOURCES = $(wildcard src/*.md src/**/*.md)

BODIES = $(patsubst src/%.md,public/%.html,$(SOURCES))

INDEXES = $(subst //,/,$(patsubst src/%,public/%/index.html,$(sort $(dir $(SOURCES)))))

DEPENDENCE_FILES = $(patsubst src/%.md,tmp/%.dep,$(SOURCES))

MKDIR = mkdir -p $(dir $@)

export EDITLINK = https://github.com/soukouki/note/edit/master/
export NEWFILELINK = https://github.com/soukouki/note/new/master/
export SOURCE_EXTENSION = txt rb py scala

.PHONY: all install clean

all: $(BODIES) $(INDEXES) public/style.css

install:
	gem install kramdown

clean:
	rm -r public || true
	rm -r tmp || true

public/%.html: tmp/%.md base.html
	$(MKDIR)
	$(RUBY) scripts/make-html.rb $* > $@ 

tmp/index.md: tmp/index.yaml
	$(MKDIR)
	$(RUBY) scripts/make-index.rb . > $@

tmp/%/index.md: tmp/index.yaml
	$(MKDIR)
	$(RUBY) scripts/make-index.rb $* > $@

tmp/%.md: src/%.md tmp/index.yaml
	$(MKDIR)
	$(RUBY) scripts/process-source.rb $* $(wordlist 3,$(words $+),$+) > $@

tmp/%.dep: src/%.*
	$(MKDIR)
	$(RUBY) scripts/make-mix-in-dependences.rb $* > $@

tmp/index.yaml: $(SOURCES)
	$(MKDIR)
	$(RUBY) scripts/index-sources.rb

public/style.css: style.css
	$(MKDIR)
	cp $< $@

-include $(DEPENDENCE_FILES)
