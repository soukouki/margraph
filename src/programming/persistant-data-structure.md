# 永続データ構造

- 変更するときに、値を直接書き換えるのではなく、変更前のバージョンを参照しながら新しいオブジェクトを作るデータ構造
- 関数型プログラミングでよく使う
  - 例えばclojureやElmの配列、リストはそう
- 一部を書き換えた完全に新しいオブジェクトを作っているとメモリが過剰に必要になるので、前のオブジェクトを参照する
- 副作用の排除をデータ構造の面から考えた感じ？
