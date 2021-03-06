# 分散

- 標準偏差を2乗したもの
  - $\sigma^2$
- 分布Xの分散を $V[X]$ として表す

## 期待値を使った分散

- 分散を、平均の代わりに期待値を使って計算する
- 離散型の場合、$\displaystyle V[X] = \sum_{k=1}^{\|\Omega\|} (x_k - E[X])^2 P(X=x_k)$
  - $E[X]$ は期待値
  - 平均の代わりに期待値を使っている
  - $\dfrac{1}{N}$ の代わりに $P(X=x_k)$ を使っている
- 連続型の場合、$\displaystyle V[X] = \int_{-\infty}^\infty (x-E[X])^2 f(x)\ dx$

- $V[X] = E[X^2] - E[X]^2$ と計算できる
  - $$
    \begin{eqnarray}
    V[X] &=& \sum_{k=1}^{|\Omega|} (x_k - E[X])^2 P(X=x_k) \\
    &=& \sum (x_l^2-2x_kE[X]+E[X]^2) P(X=x_k) \\
    &=& \sum x_k^2 P(X=x_k) -2E[X] \sum x_k P(X=x_k) + E[X]^2 \sum P(X=x_k)\\
    &=& \sum x_k^2 P(X=x_k) - E[X]^2 \\
    &=& E[X^2] - E[X]^2 \\
    \end{eqnarray}
    $$
  - 2乗の平均のほうが、大きい値の影響が大きいから大きくなる、みたいな方法で覚える
    - 分散は必ず正の数
  - $\sum x_k P(X=x_k) = E[X]$
    - 期待値の定義と同じ
  - $\sum P(X=x_k) = 1$
