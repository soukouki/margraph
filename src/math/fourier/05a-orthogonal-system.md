# 直交関数系

- 関数系(数学)で、直交であるもの
- 直交の性質は正規直交基底と似たようなもの
- これを使うと
  - $\displaystyle f(x) = \sum_{i=0}^\infty a_i \varphi_i$ としたとき、
  - $\displaystyle \int_a^b f(x) \varphi_n(x)\ dx = a_n(\varphi_n \cdot \varphi_n) = a_n \|\| \varphi_n \|\|^2$
    - $f(x)$ から特定の次元の値を取り出す感じ
  - よって $\displaystyle a_n = \frac{1}{\|\|\varphi_n\|\|^2} \int_a^b f(x)\varphi_n(x)\ dx$
    - これがフーリエ係数につながる
- ある関数系が直交関数系か見てみる
