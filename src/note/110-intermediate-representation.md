# note用中間表現

工数は増えるけれど、これは疎結合・高凝縮性の確保のために必要なんじゃないかな。これまではHTMLを生成する箇所が色んな場所に別れていたせいで、最終的な表示のためのコードがいろんな箇所に散らかってしまった。また、Markdownパーサーが生成したタグに表示用のクラスをつけることができなくて、その部分にbootstrapを設定できなかった。

独自で書き換えない部分については、ほとんどKramdownの出力をそのまま使う。タグごとにすべての中間表現を作ると、ほとんど区別しないのに異なるパターンが大量に出てしまう。なので、必要になったときに必要になった分を実装する方針にする。

pathを使う場所に関しては、aタグと中間表現で分ける。aタグの方は、実際のHTMLを直接埋め込む形にする(そうしないとリンクの内側を中間表現で持たないといけず、かなり手間がかかる)。中間表現の方は、Collect Articlesのpathと同じ形で持つようにする(拡張子などを省略することに注意)。

## 記事の中間表現
````md
# タイトル

タイトル直下のテキスト

段落毎に分けておく

## h2用タイトル

**文字装飾などについては、HTMLを直接埋め込む**
改行なんかは
そのままにしておく。andの方な特殊文字は&と置き換える
テーブルと配列に関しても、そのままぶっこむ。

```js
alert(1);
```

```
言語を指定しなかった場合、nullを入れる
```

リストの直前・直後にあるテキストは
- こんなふうに
同じelementの中に入れて、divで囲む。この仕様は頑張って実装する
````

ここに書かれていない要素は、elementの中に直接入れる

```json
{
  "title": "タイトル",
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
      "path": "aaa/index/page"
    }
  ],
  "contents": [
    {
      "type": "element",
      "text": "<p>タイトル直下のテキスト</p>"
    },
    {
      "type": "element",
      "text": "<p>複数のパラグラフが来るときには、こんな感じで</p>"
    },
    {
      "type": "header",
      "level": 2,
      "text": "h2用タイトル"
    },
    {
      "type": "element",
      "text":
        "<p><strong>文字装飾などについては、HTMLを直接埋め込む。</strong>\n"+
        "改行なんかは\nそのままにしておく。andのような特殊文字は&lt;と置き換える\n"+
        "テーブルと配列に関しても、そのままぶっこむ。</p>\n"
    },
    {
      "type": "code",
      "lang": "js",
      "text": "alert(1);"
    },
    {
      "type": "code",
      "lang": null,
      "text": "言語を指定しなかった場合は、nullを入れる"
    },
    {
      "type": "element",
      "text": "<div>リストの直前・直後にあるテキストは<ul><li>こんなふうに</li></ul>同じelementの中に入れて、divで囲む。この仕様は頑張って実装する</div>"
    },
    {
      "type": "element",
      "text": "<p>ここに書かれていない要素は、elementの中に直接入れる</p>"
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
  "next": null
}
```

目次の中間表現
```json
{
  "title": "aaaの目次",
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