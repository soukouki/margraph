# Collect Links

集められた記事のタイトルを使って、記事中からどの部分にリンクを貼るのかをまとめたリストを作る

ディレクトリ毎に実行される

## 入力

### ファイル

- `merged-articles.json`
- `src/<path>/*.md`

### コマンドライン

- 調査するディレクトリパス

## 出力

`tmp/<path>/link-network.json`を生成

配列内の順番で、どの部分のテキストを置き換えるのかを確定させる

```json
{
  "aaa/bbb": [
    {
      "title": "タイトル",
      "path": "aaa/ccc"
    },
    {
      "title": "タイトル2",
      "path": "aaa/ddd/fff"
    }
  ],
  "fff": []
}
```
