# Collect Articles

markdownファイルを解析して、タイトルとパスをまとめたリストを作る

ディレクトリ毎に実行される

## 入力

### ファイル

なし

### コマンドライン

- 調査するディレクトリパス

## 出力

### ファイル

調査したディレクトリ内に、`articles.json`を生成

`src/aaa`ディレクトリ内に`src/aaa/bbb.md`, `src/aaa/ccc.md`ファイルがあるときの実行例(整形後)
```json
[
  {
    "title": "タイトル",
    "path": ["aaa", "bbb"]
  },
  {
    "title": "タイトル2",
    "path": ["aaa", "ccc"]
  }
]
```
