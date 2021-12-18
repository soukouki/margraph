
RUBY = ruby
MKDIR = mkdir -p $(dir $@)

SOURCES = $(wildcard src/*.md src/**/*.md)
SOURCE_DIRS = $(sort $(dir $(SOURCES)))

HTML_FILES = $(patsubst src/%.md,public/%.html,$(SOURCES))
INDEXES = $(subst //,/,$(patsubst src/%,public/%/index.html,$(SOURCE_DIRS)))

TITLES_FILES = $(patsubst src/%,tmp/%/titles.yaml,$(SOURCE_DIRS))
LINK_NETWORK_FILES = $(patsubst src/%,tmp/%/network.yaml,$(SOURCE_DIRS))
ATTACH_FILES_DEPENDENCE = $(patsubst src/%,tmp/%/attache_files.dep,$(SOURCE_DIRS))

export EDITLINK = https://github.com/soukouki/note/edit/master/
export NEWFILELINK = https://github.com/soukouki/note/new/master/
export SOURCE_EXTENSION = txt rb py scala

.PHONY: all install clean

all: $(HTML_FILES) $(INDEXES) public/style.css

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

tmp/%/attache_files.dep: src/%/*
	$(MKDIR)
	$(RUBY) scripts/make-attach-files-dependence.rb $+ > $@

tmp/index.yaml: $(SOURCES)
	$(MKDIR)
	$(RUBY) scripts/index-sources.rb

public/style.css: style.css
	$(MKDIR)
	cp $< $@

-include $(ATTACH_FILES_DEPENDENCE)
