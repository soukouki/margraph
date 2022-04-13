# フーリエ級数

- $\displaystyle \sum_{n=0}^\infty a_n \varphi_n(x)$
- これまでの系の話はかなり一般化したもので、これを $\cos$ に適用すると、よく言われるフーリエ級数となる
- $\varphi_n(x) = \cos\left(\left(n+1\right) x \right)\quad(n=0,1,2,\dots)$
  - $(\varphi_i \cdot \varphi_j) = 0$ になる(らしい)
  - $(\varphi_i \cdot \varphi_i) = \dfrac{\pi}{2}$ になる(らしい)
  - $f(x)=1$ と定数関数を置いてみると、$(f \cdot \varphi_n) = 0$ となる(らしい)
  - 1と言う定数関数を処理すると0になるのは具合が悪い(らしい)
- フーリエ級数の分野で大事なこと
  - フーリエ級数が収束するための条件
  - フーリエ級数が収束するとき、それが元の関数fに一致するかどうか
    - 一致するための条件
