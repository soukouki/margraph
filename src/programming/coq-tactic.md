# Coqのタクティック

- Coqのタクティックについて、見つけたものに対してのメモ
- `move=> 変数名`
  - スタックのトップからローカルコンテキストに変数を動かす
  - SSReflectのタクティック
- `move: 変数名`
  - ローカルコンテキストからトップに変数を動かす
  - SSReflectのタクティック
- `intros`
  - 変数定義とその仮定部分に名前をつけて、コンテキストに移せる
  - 例えば、`forall x: nat, A x -> B x`に対して使うと、`forall x: nat, A x`をコンテキストに移せる
  - `move=>`と同じ動き
- `assert (型)`
  - 型に入れたものをゴールの一番上に追加する
  - すでに証明した定理をコンテキストに追加したいときに使う
    - assertとapplyを組み合わせる
  - SSReflectのタクティクスが使えるなら、move: で持ってくるほうが楽
- `generalize dependent 変数名`
  - コンテキストの変数を、forallの形でトップに持ってくる
  - `move:`と似てるけれど、置き換えられる場合と置き換えられない場合がある
- `distruct 変数名`
  - 変数の型を分解する。例えば、pが`pair (n1 n2)`のようなら、`distruct p`とするとn1とn2が出てくる
  - `distruct 変数名 as [変数名]`
- `apply`
  - トップにある定理を使って、他の要素を置き換える
  - moveと合わせた動きも書けるらしい
  - `apply /補題名`
    - 補題を使うこともできる
  - SSReflectのタクティック
- `assumption`
  - コンテキストを使ってゴールに変換できる仮説を探す
  - `by []`の一部機能みたいな感じかな？
- `unfold`
  - 指定した名前の定義を展開してくれる
- `rewrite 補題名`
  - 関数・補題を指定して、その式を左辺のものから右辺のものに置き換える
  - `rewrite -補題名`
    - 右辺から左辺に置き換えるものに変わる
  - `rewrite /=`
    - 定義をたどる程度の計算をしてくれる
  - `rewrite /定義名`
    - 定義名の定義を紐解いて、展開してくれる
  - `rewrite -/定義名`
    - 定義名の定義に基づいて、折りたたんでくれる
  - `rewrite (_ : もとの変数名 = 新しい変数名)`
    - 変数を置き換えて、置き換えに必要なゴールを追加する
    - substでできる場合はsubstを使ったほうが簡単
  - SSReflectのタクティック
- `subst`
  - `n = m`のような置き換えがコンテキストにあったときに、自動で置き換えてくれる
- `case`
  - 場合分けをする
- `case_eq`
  - `case`に加えて、場合分けするときの条件を仮定につけてくれる
  - `b = x1 < x2`のbに対して場合分けするときなどに、`b = true`, `b = false`などと仮定を付けてくれる
- `elim`
  - 帰納法を使う
  - SSReflectのタクティック
- `induction`
  - 帰納法を使う
- `clear`
   - 指定したコンテキストを削除する
   - コンテキストを別の形に変換して、残った元のやつを消すときに使う
- `have: (命題)` `suff: (命題)`
  - Aという命題があるときにBという命題を指定すると、A->BとBの2つのゴールに分けて証明できる
  - haveではB, A->Bの順で、Bが簡単なときに適している
  - suffではA->B, Bの順になる
- `specialize (補題名 変数名)`
  - forallになっているコンテキストに対して、変数を指定する
- `inversion 補題名`
  - Inductiveで定義された関係を見て、それに合致する命題をいくつか生成する
- `exists`
  - existになってるトップに対して使えるっぽい？
- `try タクティック名`
  - 名前から想像するに、失敗してもいい的な・・・？
- `split`
  - `A /\ B` となっていて、分けて証明するときに使える
- `by (タクティック)`
  - SSReflectにおいて、サブゴールを閉じる目印にする
  - 自動である程度推論してくれる機能があるので、便利
  - 特にタクティックを指定しない場合は、`by []`とする
  - SSReflectのタクティック
- `set (変数名) := (変数の中身)`
  - 式に対して新しい変数で置き換える
  - ごちゃごちゃしてる式に対して、名前を付け直すことで証明を整理できる
- `rename (元の変数名) into (変更先の名前)`
  - 変数名を変更できる
  - 意味のある変数名を使って、証明の際の混乱を減らす
    - 例えば、配列なら`x1 :: x2 :: x3 :: xs4`のように、連番にしてみるなど
