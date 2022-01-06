
RUBY = ruby
MKDIR = mkdir -p $(dir $@)

SOURCES = $(wildcard src/*.md src/*/*.md src/*/*/*.md src/*/*/*/*.md src/*/*/*/*/*.md)
SOURCE_DIRS = $(sort $(dir $(SOURCES)))

HTML_FILES = $(patsubst src/%.md,public/%.html,$(SOURCES))
INDEXES = $(subst //,/,$(patsubst src/%,public/%index.html,$(SOURCE_DIRS)))

ARTICLE_LIST_FILES = $(patsubst src/%,tmp/%article_list.yaml,$(SOURCE_DIRS))
LINK_NETWORK_FILES = $(patsubst src/%,tmp/%network.yaml,$(SOURCE_DIRS))
ATTACH_FILES_DEPENDENCE = $(patsubst src/%,tmp/%attache_files.dep,$(SOURCE_DIRS))

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

# (開発中)ネットワーク可視化

tmp/network.dot: tmp/merged_network.yaml
	$(MKDIR)
	ruby scripts/draw-network.rb > tmp/network.dot

tmp/network.png: tmp/network.dot
	$(MKDIR)
	dot tmp/network.dot -Tpng -o tmp/network.png

# public内のファイル

public/%.html: tmp/%.md base.html
	$(MKDIR)
	$(RUBY) scripts/make-html.rb $* > $@

public/style.css: style.css
	$(MKDIR)
	cp $< $@

# 変換用のマークダウン

tmp/index.md: tmp/merged_article_list.yaml
	$(MKDIR)
	$(RUBY) scripts/make-index.rb . > $@

tmp/%/index.md: tmp/merged_article_list.yaml
	$(MKDIR)
	$(RUBY) scripts/make-index.rb $* > $@

tmp/%.md: src/%.md tmp/merged_article_list.yaml tmp/merged_network.yaml
	$(MKDIR)
	$(RUBY) scripts/process-source.rb $* $(wordlist 4,$(words $+),$+) > $@

# 変換用のデータ作成

tmp/%/article_list.yaml: src/%/*.md
	$(MKDIR)
	$(RUBY) scripts/collect-articles.rb $* $(patsubst src/%.md,%,$+) > $@

tmp/article_list.yaml: src/*.md
	$(MKDIR)
	$(RUBY) scripts/collect-articles.rb "." $(patsubst src/%.md,%,$+) > $@

tmp/merged_article_list.yaml: $(ARTICLE_LIST_FILES)
	$(MKDIR)
	$(RUBY) scripts/merge-yaml.rb $+ > $@

tmp/%/network.yaml: tmp/merged_article_list.yaml src/%/*.md
	$(MKDIR)
	$(RUBY) scripts/search-link.rb $(patsubst src/%.md,%,$(wordlist 2,$(words $+),$+)) > $@

tmp/network.yaml: tmp/merged_article_list.yaml src/*.md
	$(MKDIR)
	$(RUBY) scripts/search-link.rb $(patsubst src/%.md,%,$(wordlist 2,$(words $+),$+)) > $@

tmp/merged_network.yaml: $(LINK_NETWORK_FILES)
	$(MKDIR)
	$(RUBY) scripts/merge-yaml.rb $+ > $@

# 添付ファイル用の依存関係

tmp/%/attache_files.dep: src/%/*
	$(MKDIR)
	$(RUBY) scripts/make-attach-files-dependence.rb $+ > $@

-include $(ATTACH_FILES_DEPENDENCE)
