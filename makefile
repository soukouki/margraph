
MKDIR = mkdir -p $(dir $@)
MERGE_JSON = ruby scripts/merge-json/merge-json.rb
COLLECT_ARTICLES = ruby scripts/collect-articles/collect-articles.rb
COLLECT_LINKS = ruby scripts/collect-links/collect-links.rb
PARSE_MARKDOWN = ruby scripts/parse-markdown/parse-markdown.rb
MAKE_INDEX = ruby scripts/make-index/make-index.rb
MAKE_HTML = ruby scripts/make-html/make-html.rb
SEARCH_ATTACHMENT_FILES = ruby scripts/search-attachment-files/search.rb

SOURCES = $(wildcard src/*.md src/*/*.md src/*/*/*.md src/*/*/*/*.md src/*/*/*/*/*.md) # 無数にあるが、うまく扱えなかったのでとりあえず
SOURCE_DIRS = $(sort $(dir $(SOURCES)))

HTML_FILES = $(patsubst src/%.md,public/%.html,$(SOURCES))
INDEXES = $(subst //,/,$(patsubst src/%,public/%index.html,$(SOURCE_DIRS)))

ARTICLES_FILES = $(patsubst src/%,tmp/%articles.json,$(SOURCE_DIRS))
LINK_NETWORK_FILES = $(patsubst src/%,tmp/%link-network.json,$(SOURCE_DIRS))
ATTACH_FILES_DEPENDENCE = $(patsubst src/%,tmp/%attache_files.dep,$(SOURCE_DIRS))

export EDITLINK = https://github.com/soukouki/margraph/edit/master/
export NEWFILELINK = https://github.com/soukouki/margraph/new/master/
export SOURCE_EXTENSION = txt rb py scala

.PHONY: all install clean

all: $(HTML_FILES) $(INDEXES) public/style.css

install:
	gem install kramdown

clean:
	rm -r public || true
	rm -r tmp || true

public/style.css: style.css
	$(MKDIR)
	cp style.css public/style.css

# (開発中)ネットワーク可視化

tmp/network.dot: tmp/merged-link-network.json
	$(MKDIR)
	ruby scripts/draw-network.rb > tmp/network.dot

tmp/network.png: tmp/network.dot
	$(MKDIR)
	dot tmp/network.dot -Tpng -o tmp/network.png

# 変換用の一時データ生成

tmp/%/articles.json: src/%/*.md
	$(MKDIR)
	$(COLLECT_ARTICLES) $*

tmp/articles.json: src/*.md
	$(MKDIR)
	$(COLLECT_ARTICLES) ""

tmp/merged-articles.json: $(ARTICLES_FILES)
	$(MERGE_JSON) $@ $^

tmp/%/link-network.json: tmp/merged-articles.json src/%/*.md
	$(COLLECT_LINKS) $*

tmp/link-network.json: tmp/merged-articles.json src/*.md
	$(COLLECT_LINKS) ""

tmp/merged-link-network.json: $(LINK_NETWORK_FILES)
	$(MERGE_JSON) $@ $^

tmp/%.inter.json: src/%.md tmp/merged-articles.json tmp/merged-link-network.json
	$(PARSE_MARKDOWN) $*

tmp/%/index.inter.json: src/%/*.md tmp/merged-articles.json
	$(MAKE_INDEX) $*

tmp/index.inter.json: src/*.md tmp/merged-articles.json
	$(MAKE_INDEX) ""

public/%.html: tmp/%.inter.json scripts/make-html/base.erb
	$(MKDIR)
	$(MAKE_HTML) $*
