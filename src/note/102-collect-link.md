# Collect Link

集められた記事のタイトルを使って、記事中からどの部分にリンクを貼るのかをまとめたリストを作る

ディレクトリ毎に実行される

## 入力

### ファイル

- `merged-articles.json`

### コマンドライン

- 調査するディレクトリ

## 出力

調査したディレクトリ内に、`link-network.json`を生成

配列内の順番で、どの部分のテキストを置き換えるのかを確定させる
```json
{
  "aaa/bbb": [
    {
      "title": "タイトル",
      "path": "aaa/ccc",
      "surrounding_text": "改行はそのまま\nタイトル付近の文字列"
    },
    {
      "title": "タイトル2",
      "path": "aaa/ddd/fff",
      "surrounding_text": "端っこの方にかかる場合もある\  例えばタイトル2"
    }
  ],
  "fff": []
}
```
