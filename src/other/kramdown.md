# Kramdown

公式ページ
: https://kramdown.gettalong.org/index.html

gemのドキュメント
: https://kramdown.gettalong.org/rdoc/index.html

ソースコード
: https://github.com/gettalong/kramdown

## Convertの流れ
Kramdownで、`Kramdown::Document.new("# header").to_html`の内部を追ってみたときのメモ

1. `Kramdown::Document#method_missing`で、Converterの中から動的に選択して取ってくる
2. `Kramdown::Converter::Base#convert`で、`Converter::Html.new`ってやってConverterを生成
3. `Kramdown::Converter::Html#convert`で、sendを使って`converter_*`を呼んでいく


