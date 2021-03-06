# 再帰的な項の定義と具体的な項の定義は等しい

命題3.2.6(再帰的な項の定義と具体的な項の定義は等しい)について

- $\mathcal{T}$ はある条件を満たす最小の集合として定義されている
  - 次の2条件を満たせば、$\mathcal{T} = S$ が証明される
    - (a) $S$ が $\mathcal{T}$ の条件を満たすこと
      - これで、$S \subseteq \mathcal{T}$ であることがわかる
    - (b) $\mathcal{T}$ を満たす任意の集合 $S'$ が $S$ を部分集合として持つこと
      - つまり、$\mathcal{T}$ だが $S$ ではない集合がないことがわかる
      - これで、$\mathcal{T} \subseteq S$ であることがわかる
- (a)
  - 下の2つのことを示して、帰納法で証明する
    - 定数は $S$ に含まれる
    - $t_1 \in S$ ならば $t_1 \in S_i$ であり、$\mathrm{succ}\ t_1, \mathrm{pred}\ t_1, \mathrm{iszero}\ t_1$ はそれぞれ $S_{i+1}$に含まれる
    - 同様に、$\mathrm{if}\ t_1\ \mathrm{then}\ t_2\ \mathrm{else}\ t_3 \in S$
- (b)
  - $S' \subseteq \mathcal{T}$ のとき、$S_i \subseteq S'$であることを求める
    - $S_i \subseteq S' \subseteq \mathcal{T}$ となる
  - $i = 0$ のときと $i > 0$ のときに分け、帰納法を使って証明する
  - $i = 0$ のとき
    - $S_i = \varnothing$ なので、明らかに $S_i \subseteq S'$
  - $i > 0$ のとき
    - $t$ が定数ならば
      - $t \in S'$ は明らか
    - $t_1 \in S_j$ に対して、$t$ が $\mathrm{succ}\ t_1, \mathrm{pred}\ t_1, \mathrm{iszero}\ t_1$ならば
      - $t_1 \in S'$ となり、$t \in S'$ が成り立つ
    - 同様に $\mathrm{if}\ t1\ \mathrm{then}\ t2\ \mathrm{else}\ t3 \in S'$ が成り立つ
