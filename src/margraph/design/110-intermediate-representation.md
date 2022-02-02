# margraph用中間表現

工数は増えるけれど、これは疎結合・高凝縮性の確保のために必要なんじゃないかな。これまではHTMLを生成する箇所が色んな場所に別れていたせいで、最終的な表示のためのコードがいろんな箇所に散らかってしまった。また、Markdownパーサーが生成したタグに表示用のクラスをつけることができなくて、その部分にbootstrapを設定できなかった。

独自で書き換えない部分については、ほとんどKramdownの出力をそのまま使う。タグごとにすべての中間表現を作ると、ほとんど区別しないのに異なるパターンが大量に出てしまう。なので、必要になったときに必要になった分を実装する方針にする。

pathを使う場所に関しては、aタグと中間表現で分ける。aタグの方は、実際のHTMLを直接埋め込む形にする(そうしないとリンクの内側を中間表現で持たないといけず、かなり手間がかかる)。中間表現の方は、Collect Articlesのpathと同じ形で持つようにする(拡張子などを省略することに注意)。

## 記事の中間表現

記事の中間表現のテスト用

また同名の画像ファイルとコードファイルがあり、margraphの添付ファイルとして導入されるとする

ここに書かれていない要素は、elementの中に直接入れる

```json
{
  "type": "article",
  "title": "記事の中間表現のサンプル",
  "breadcrumb": [
    {
      "title": "note",
      "path": "index"
    },
    {
      "title": "aaa",
      "path": "aaa/index"
    },
    {
      "title": "page",
      "path": "aaa/page"
    }
  ],
  "contents": [
    {
      "type": "element",
      "text": "<div>タイトル直下のテキスト</div>"
    },
    {
      "type": "element",
      "text": "<div>複数のパラグラフが来るときには、こんな感じで</div>"
    },
    {
      "type": "header",
      "level": 2,
      "text": "h2用タイトル"
    },
    {
      "type": "element",
      "text":
        "<div><strong>文字装飾などについては、HTMLを直接埋め込む。</strong>\n"+
        "改行なんかは\nそのままにしておく。andのような特殊文字は&lt;と置き換える\n"+
        "テーブルと配列に関しても、そのままぶっこむ。</div>\n"
    },
    {
      "type": "code",
      "lang": "js",
      "code": "alert(1);"
    },
    {
      "type": "code",
      "lang": null,
      "code": "言語を指定しなかった場合は、nullを入れる"
    },
    {
      "type": "element",
      "text": "<div>リストの直前・直後にあるテキストは<ul><li>こんなふうに</li></ul>同じelementの中に入れて、divで囲む。この仕様は頑張って実装する</div>"
    },
    {
      "type": "element",
      "text": "<div>ここに書かれていない要素は、elementの中に直接入れる</div>"
    },
    {
      "type": "image",
      "path": "aaa/<記事のファイル名>",
      "extension": "png"
    },
    {
      "type": "code",
      "lang": "py",
      "code": "langは拡張子を使う"
    }
  ],
  "prev": {
    "title": "前の記事のタイトル",
    "path": "aaa/prev"
  },
  "index": {
    "title": "目次のタイトル",
    "path": "aaa/index"
  },
  "next": null,
  "links": [
    {
      "title": "タイトル",
      "path": "aaa/bbb/title",
      "opening": "タイトルとは、文章の",
      "image": null,
      "links": [
        {
          "title": "文章",
          "path": "aaa/bbb/sentence",
          "opening": "文章とは、",
          "image": {
            "path": "aaa/bbb/sentence-image1",
            "extension": "png"
          }
        }
      ]
    }
  ]
}
```

目次の中間表現

```json
{
  "type": "index",
  "title": "aaa",
  "breadcrumb": [
    {
      "title": "note",
      "path": "index",
    },
    {
      "title": "aaa",
      "path": "aaa/index"
    }
  ],
  "dirs": [
    {
      "title": "ディレクトリのタイトル",
      "path": "aaa/direc"
    }
  ],
  "files": [
    {
      "title": "ファイルのタイトル",
      "path": "aaa/page"
    }
  ]
}
```