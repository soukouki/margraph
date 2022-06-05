
MKDIR = mkdir -p $(dir $@)

# If the target file is exist, backup it.
LAY_OLD = \
if test -e $@; then \
	mv $@ $@.old; \
fi
# If new target file is same as old one, replace it.
LAY_NEW = \
if test -e $@.old; then \
	if diff -q $@ $@.old; then \
	  mv $@.old $@; \
	else \
	  rm $@.old; \
	fi; \
fi

MERGE_JSON := ruby scripts/merge-json/merge-json.rb
COLLECT_ARTICLES := ruby scripts/collect-articles/collect-articles.rb
COLLECT_LINKS := ruby scripts/collect-links/collect-links.rb
PARSE_MARKDOWN := ruby scripts/parse-markdown/parse-markdown.rb
MAKE_INDEX := ruby scripts/make-index/make-index.rb
MAKE_HTML := ruby scripts/make-html/make-html.rb
SEARCH_ATTACHMENT_FILES := ruby scripts/search-attachment-files/search.rb
MAKE_DEPENDENCE := ruby scripts/make-dependence/make-dependence.rb

SOURCES := $(wildcard src/*.md src/*/*.md src/*/*/*.md src/*/*/*/*.md src/*/*/*/*/*.md) # 無数にあるが、うまく扱えなかったのでとりあえず
SOURCE_DIRS := $(sort $(dir $(SOURCES)))

DEPENDENCE_FILES := $(subst //,/,$(patsubst src/%,tmp/%dependence.dep,$(SOURCE_DIRS)))

HTML_ARTICLES := $(patsubst src/%.md,public/%.html,$(SOURCES)) public/network.html
INDEXES := $(subst //,/,$(patsubst src/%,public/%index.html,$(SOURCE_DIRS)))
HTML_FILES := $(HTML_ARTICLES) $(INDEXES)

ARTICLES_FILES := $(patsubst src/%,tmp/%articles.json,$(SOURCE_DIRS))
LINK_NETWORK_FILES := $(patsubst src/%,tmp/%link-network.json,$(SOURCE_DIRS))
ATTACHMENTS_FILES := $(patsubst src/%,tmp/%attachments-files.json,$(SOURCE_DIRS))
HTML_INTER_FILES := $(patsubst public/%.html,tmp/%.inter.json,$(HTML_FILES))

export EDITLINK = https://github.com/soukouki/margraph/edit/master/
export NEWFILELINK = https://github.com/soukouki/margraph/new/master/
export SOURCE_EXTENSION = txt rb py scala

include $(DEPENDENCE_FILES)

.PHONY: all install clean
.PRECIOUS : $(DEPENDENCE_FILES) $(ARTICLES_FILES) $(LINK_NETWORK_FILES) $(ATTACHMENTS_FILES) $(HTML_INTER_FILES) tmp/merged-articles.json tmp/merged-link-network.json

all: $(HTML_FILES) public/style.css

install:
	gem install kramdown

clean:
	rm -r public || true
	rm -r tmp || true

public/style.css: style.css
	$(MKDIR)
	cp style.css public/style.css

# ネットワーク可視化

tmp/network.dot: tmp/merged-link-network.json
	ruby scripts/draw-network.rb > tmp/network.dot

tmp/network.png: tmp/network.dot
	dot tmp/network.dot -Tpng -o tmp/network.png

# HTMLの変換

tmp/%/articles.json: src/%/*.md
	$(MKDIR)
	$(LAY_OLD)
	$(COLLECT_ARTICLES) $*
	$(LAY_NEW)

tmp/articles.json: src/*.md
	$(MKDIR)
	$(LAY_OLD)
	$(COLLECT_ARTICLES) ""
	$(LAY_NEW)

tmp/merged-articles.json: $(ARTICLES_FILES)
	$(LAY_OLD)
	$(MERGE_JSON) $@ $^
	$(LAY_NEW)

tmp/%/link-network.json: tmp/merged-articles.json src/%/*.md
	$(LAY_OLD)
	$(COLLECT_LINKS) $*
	$(LAY_NEW)

tmp/link-network.json: tmp/merged-articles.json src/*.md
	$(LAY_OLD)
	$(COLLECT_LINKS) ""
	$(LAY_NEW)

tmp/merged-link-network.json: $(LINK_NETWORK_FILES)
	$(LAY_OLD)
	$(MERGE_JSON) $@ $^
	$(LAY_NEW)

tmp/%.inter.json: src/%.md tmp/merged-articles.json tmp/merged-link-network.json $(ATTACHMENTS_FILES)
	$(LAY_OLD)
	$(PARSE_MARKDOWN) $*
	$(LAY_NEW)

tmp/%/index.inter.json: src/%/*.md tmp/merged-articles.json
	$(LAY_OLD)
	$(MAKE_INDEX) $*
	$(LAY_NEW)

tmp/index.inter.json: src/*.md tmp/merged-articles.json
	$(LAY_OLD)
	$(MAKE_INDEX) ""
	$(LAY_NEW)

public/%.html: tmp/%.inter.json scripts/make-html/base.erb
	$(MKDIR)
	$(LAY_OLD)
	$(MAKE_HTML) $*
	$(LAY_NEW)

public/network.html: tmp/network.inter.json scripts/make-html/base.erb public/network.png
	$(MKDIR)
	$(LAY_OLD)
	$(MAKE_HTML) network
	$(LAY_NEW)

tmp/network.inter.json: scripts/network.inter.json
	$(MKDIR)
	cp scripts/network.inter.json tmp/network.inter.json

public/network.png: tmp/network.png
	cp tmp/network.png public/network.png

# 依存関係

tmp/%/attachments-files.json: src/%/*
	$(MKDIR)
	$(SEARCH_ATTACHMENT_FILES) $*

tmp/attachments-files.json: src/*
	$(MKDIR)
	$(SEARCH_ATTACHMENT_FILES) ""

tmp/%/dependence.dep: tmp/%/attachments-files.json
	$(MAKE_DEPENDENCE) $*

tmp/dependence.dep: tmp/attachments-files.json
	$(MAKE_DEPENDENCE) ""

