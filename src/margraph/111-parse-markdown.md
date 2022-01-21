# Parse Markdown

Markdownをパースして、margraph用中間表現を生成する。aタグなどのリンクの反映、添付ファイルの埋め込みはこの段階で行う。

Markdownファイル毎に実行される

## 入力

### ファイル

- `src/<path>.md`
- `merged-articles.json`
- `merged-link-network.json`
- `tmp/<pahtのディレクトリ>/attached-files.json`

### コマンドライン

- 変換するファイル

## 出力

`tmp/<パス>.inter.json`にmargraph用中間表現を出力
