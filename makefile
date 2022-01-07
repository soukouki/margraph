
MKDIR = mkdir -p $(dir $@)
MERGE_JSON = ruby scripts/merge-json/merge-json.rb
COLLECT_ARTICLES = ruby scripts/collect-articles/collect-articles.rb

SOURCES = $(wildcard src/*.md src/*/*.md src/*/*/*.md src/*/*/*/*.md src/*/*/*/*/*.md) # 無数にあるが、うまく扱えなかったのでとりあえず
SOURCE_DIRS = $(sort $(dir $(SOURCES)))

HTML_FILES = $(patsubst src/%.md,public/%.html,$(SOURCES))
INDEXES = $(subst //,/,$(patsubst src/%,public/%index.html,$(SOURCE_DIRS)))

ARTICLES_FILES = $(patsubst src/%,tmp/%articles.json,$(SOURCE_DIRS))
LINK_NETWORK_FILES = $(patsubst src/%,tmp/%network.yaml,$(SOURCE_DIRS))
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

# (開発中)ネットワーク可視化

tmp/network.dot: tmp/merged_network.yaml
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
	$(COLLECT_ARTICLES) .

tmp/merged-articles.json: $(ARTICLES_FILES)
	$(MERGE_JSON) $@ $^
