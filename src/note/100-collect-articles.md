# Collect Articles

Markdownファイルを解析して、タイトルとパスをまとめたリストを作る

ディレクトリ毎に実行される

## 入力

### ファイル

- `src/<path>/*.md`

### コマンドライン

- 調査するディレクトリパス

## 出力

### ファイル

`tmp/<path>/articles.json`を生成

`src/aaa`ディレクトリ内に`src/aaa/bbb.md`, `src/aaa/ccc.md`ファイルがあるときの実行例(整形後)
```json
{
  "files": {
    "aaa/bbb": {
      "title": "タイトル"
    },
    "aaa/ccc": {
      "title": "タイトル2"
    }
  },
  "dirs": {
    "aaa": {
      "title": "aaa"
    }
  }
}
```
