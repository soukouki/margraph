# 系(数学)

- ベクトルで扱っていたものを関数に適用していく
  - $\displaystyle (f \cdot g) = \int_a^b f(x)g(x)\ dx$
  - $\displaystyle \|\|f\|\| = (f \cdot f)^\frac{1}{2} = \left(\int_a^b f(x)^2\ dx \right)^\frac{1}{2}$
  - $\|\| \varphi_i \|\| = 1$
  - $(\varphi_i \cdot \varphi_i) = 1$
  - $(\varphi_i \cdot \varphi_j) = 0\quad(i \neq j)$
- これを使うと
  - $\displaystyle \int_a^b f(x) \varphi_n(x)\ dx = a_n(\varphi_n \cdot \varphi_n) = a_n \|\| \varphi_n \|\|^2$
  - よって $\displaystyle a_n = \frac{1}{\|\|\varphi_n\|\|^2} \int_a^b f(x)\varphi_n(x)\ dx$
    - これがフーリエ係数につながる
- これなんか群論ににてない？
  - ベクトルで扱っていたものを関数に適用できないか試すところとか
