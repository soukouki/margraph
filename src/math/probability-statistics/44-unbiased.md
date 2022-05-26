# 不遍性

- 普遍性(ubiguitousness)とは似ているが異なる
- $E[\hat \theta] = \theta$
  - $\hat \theta$ は推定値
  - 推定値をたくさん集めていったとき、それらの期待値は母数になるような性質
  - その証明
    - $$ 
      \begin{eqnarray}
      E[\bar X] &=& E\left[ \dfrac{X_1+X_2+\dots+X_n}{n} \right] \\
      &=& E \left[ \dfrac{X_1}{n} \right] + E \left[ \dfrac{X_2}{n} \right] + \dots + E \left[ \dfrac{X_n}{n} \right] \\
      &=& \dfrac{1}{n} E[X_1] + \dfrac{1}{n} E[X_2] + \dots + \dfrac{1}{n} E[X_n] \\
      &=& \dfrac{1}{n} \sum_{i=1}^n E[X] \\
      &=& \mu
      \end{eqnarray}
      $$
    - $\mu$ は標本値
    - これ最後が等しいかどうかよくわからんな
  - これは分散には成り立たないので注意！
    - $E[S^2] = \dfrac{n-1}{n} \sigma^2$
      - $\S^2$ は標本分散
      - $\sigma^2$ は母分散
      - この方式で求めた分散を $s^2$ と書く
        - 不遍分散という
        - $\displaystyle s^2 = \frac{\sum_{i=1}^n(X_i - \bar X)^2}{n-1}$
