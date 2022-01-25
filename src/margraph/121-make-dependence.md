# Make Dependence

Search Attachment Filesで探したmargraphの添付ファイルのリストから、Makefileで読み込むための依存関係ファイルを生成する

ディレクトリ毎に実行される

## 入力

### ファイル

- `tmp/<path>/attachments-files.json`

### コマンドライン

- 扱うディレクトリ

## 出力

### ファイル

- `tmp/<path>/dependence.dep`

makefileにそのままincludeするためのファイル
- Parse Markdownを呼び出す時の依存ファイルにファイルを入れる
- srcからpublicにファイルをコピーするためのタスクを入れる
- publicのHTMLファイルの依存ファイルにファイルを入れる

HTMLの表示に必要なファイル(例えば画像)なら、`public/**/*.html`の依存関係に入れ込むようにする
