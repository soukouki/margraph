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
  - 多分`move=>`とほぼ同じ動き
- `generalize dependent 変数名`
  - コンテキストの変数を、forallの形でトップに持ってくる
  - 多分`move:`とほぼ同じ動き
- `apply`
  - トップにある定理を使って、他の要素を置き換える
  - moveと合わせた動きも書けるらしい
  - `apply /補題名`
    - 補題を使うこともできる
  - SSReflectのタクティック
- `unfold`
  - 指定した名前の定義を展開してくれる
- `rewrite 補題名`
  - 関数・補題を指定して、その式を左辺のものから右辺のものに置き換える
  - `rewrite- 補題名`
    - 右辺から左辺に置き換えるものに変わる
  - `rewrite /=`
    - 定義をたどる程度の計算をしてくれる
  - `rewrite /定義名`
    - 定義名の定義を紐解いて、展開してくれる
  - SSReflectのタクティック
- `case`
  - 場合分けをする
  - SSReflectのタクティック
- `elim`
  - 帰納法を使う
  - SSReflectのタクティック
- `induction`
  - 帰納法を使う
- `clear`
   - 指定したコンテキストを削除する
   - コンテキストを別の形に変換して、残った元のやつを消すときに使う
- `specialize (補題名 変数名)`
  - forallになっているコンテキストに対して、変数を指定する
- `inversion __ as (__, __)`
  - existになってるコンテキストに対して使えるっぽい？
- `exists`
  - existになってるトップに対して使えるっぽい？
- `try タクティック名`
  - 名前から想像するに、失敗してもいい的な・・・？
- `assumption`
  - 謎
- `split`
  - 謎