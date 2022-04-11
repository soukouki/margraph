# Elmをぶんぶんに教えた時のメモ

- 説明の流れ
  - The Elm Architectureを軽く説明
  - Buttons
    - 足し引きするボタンを追加してみたりとか
  - 関数型とは〰的な？
  - Text Fields
  - Forms
  - ライブラリの探し方
  - TODOリスト作ってみる
    - 前半の重め演習かな？
    - 実際にループ処理で詰まってもらう
  - 無名関数とパイプ
    - さっきのTODOリストをこの機能を使って書き換えてみる、とか？
  - Forms
  - 乱数
    - 例を適当に
  - Book
    - なんかのAPIを触ってみる
    - https://cdn2.dott.dev/data.json
      - 福島県の新型コロナのデータ
    - https://www.jma.go.jp/bosai/forecast/data/forecast/070000.json
      - 天気予報のデータ
    - https://zenn-api.netlify.app
      - こっちはababさん主催の勉強会で触ったやつ
    - ライブラリ的にJSONのAPIを条件にしたほうが良い
    - JSONのDecoderで詰まると思うので、フォローアップはしっかりめにやる
      - 入れ子になったJSONを解析する方法をサンプルコードで示してあげたほうが良い
  - Elmの環境構築
  - 外部ライブラリ
- アンケート
  - 通して
    - 面白かった
  - どこらへん？
    - 関数型が触ったことのない概念で面白かった
  - 難しいところとか
    - 関数型であるところ
    - 雰囲気がつかめたくらい
  - 詰まった点とか
    - 聞いて解決できた
  - 教え方で分かりづらい点
    - とりあえずは問題ない
- JSON周りのつまり方がエグかった
  - 小さいDecoderを使って解析する、と言う流れに馴染みがなかった
    - 手続きではあまり見ない形ではあるかも