# 指数分布

- $f(x) = \lambda \exp(- \lambda x)$
- 0のとき $\lambda$、大きくなるほど0に近づく、マイナスの方は考えない
- ランダムな間隔で発生するようなイベントが発生する間隔を表す確率分布
  - ポアソン分布は起こる頻度を表す
  - 指数分布は起こる間隔を表す
- 期待値 $E[x] = \dfrac{1}{\lambda}$
  - 発生頻度 $\lambda$ が大きくなると、起こる間隔も小さくなる
- 分散 $V[x] = \dfrac{1}{\lambda^2}$
  - 期待値を使った分散の計算方法を見ると、2乗が出てくるのでわかるかも・・・？無理かも。