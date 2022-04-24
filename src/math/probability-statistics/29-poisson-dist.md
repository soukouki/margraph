# ポワソン分布

- 二項分布 $Bi(n,p)$ の試行回数 $n$ を大きく、確率 $p$ を小さくして、レート $\lambda = np$ となる確率分布
  - 例えば、宝くじで1等が当たる確率とか
- $Po(\lambda) = \dfrac{\lambda^x}{x!}\ e^{-\lambda}$
- ランダムにレート係数 $\lambda$ で発生する事象が $x$ 回起きる確率
  - なんでそう言えるの？
- 期待値 $E[x] = \lambda$
- 分散 $V[X] = \lambda$
- $$
  \begin{eqnarray}
  P(x) &=& \dbinom{n}{x}\ p^x\ (1-p)^{n-x} \\
  &=& \dots \\
  &=& \dfrac{\lambda^x}{x!}
  \end{eqnarray}
  $$
  - がんばって計算するとこうなるらしい
