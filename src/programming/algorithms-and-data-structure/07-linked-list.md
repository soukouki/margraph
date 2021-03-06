# 連結リスト

その要素と、次の要素(または前後の要素)へのポインタをもつものが、鎖状につながっているイメージ

- 片方向連結リスト
  - 要素と、次の要素へのポインタの構造が、鎖状につながるイメージ
  - 前の要素を取得する事ができないので、後ろから辿ろうとすると$O\left(n^2\right)$かかってしまう
  - 要素の後ろ側への挿入は$O\left(1\right)$
  - 要素の次の要素の削除も$O\left(1\right)$
- 双方向連結リスト
  - 要素と、前後の要素へのポインタの構造が、鎖状につながるイメージ
  - 前後の要素を取得できるので、後ろからたどっていくことも$O\left(n\right)$でできる
  - 要素の付近への挿入は$O\left(1\right)$
  - 要素の付近の削除も$O\left(1\right)$

どちらにしろ、k番目の要素へのアクセスは、片方向連結リストなら$O\left(k\right)$、双方向連結リストなら$ O\left(\min\left(k, n-k\right)\right) $かかり、配列より遅いので注意が必要。
