# 直行系

- ベクトルで扱っていたものを関数に適用していく
  - $\displaystyle (f \cdot g) = \int_a^b f(x)g(x)\ dx$
    - $(f \cdot g)$ を、2関数を掛けて積分を取ったものと定義する
  - $\displaystyle \|\|f\|\| = (f \cdot f)^\frac{1}{2} = \left(\int_a^b f(x)^2\ dx \right)^\frac{1}{2}$
    - 絶対値(ノルム)は、さっきの積を使って定義する
  - $(\varphi_i \cdot \varphi_j) = 0\quad(i \neq j)$
    - 添字が違うとき、掛けると0になる
    - ベクトルの内積みたい
- これを使うと
  - $\displaystyle f(x) = \sum_{i=0}^\infty a_i \varphi_i$ としたとき、
  - $\displaystyle \int_a^b f(x) \varphi_n(x)\ dx = a_n(\varphi_n \cdot \varphi_n) = a_n \|\| \varphi_n \|\|^2$
    - $f(x)$ から特定の次元の値を取り出す感じ
  - よって $\displaystyle a_n = \frac{1}{\|\|\varphi_n\|\|^2} \int_a^b f(x)\varphi_n(x)\ dx$
    - これがフーリエ係数につながる
- これなんか群論ににてない？
  - ベクトルで扱っていたものを関数に適用できないか試すところとか
