# Minimal Cake Pattern

- Scalaなどのプログラミング言語において、依存性注入を実現するためのデザインパターン
- https://qiita.com/tayama0324/items/03ba48d3277079f20500
- 抽象フィールドの宣言を行うトレイトと、実態の定義を行うトレイトに分ける
  - Mix-inを使う
- 実装規約
  - Usesトレイト
    - > SomeClass への依存を表現するトレイトとして trait UsesSomeClass を定義します。
  - Mix-inトレイトの定義
    - > SomeClass を注入するためのクラスとして trait MixInSomeClass を定義します。
  - 依存性の宣言と注入
    - > UsesSomeClass を継承することで SomeClass への依存を表現します。同様に、 MixInSomeClass を継承することで SomeClass インスタンスを注入します。
