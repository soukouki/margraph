# 完全系

- 閉区間 $[a, b]$ で定義された関数 $f$ のうち、$(f \cdot \varphi_n) = 0$ となる系を完全系と呼ぶ
- ただし $f=0$ は除く
- たとえば
  - $\varphi$ が以下のとき
    - $\varphi(x) = 1$
    - $\varphi_{2n-1}(x) = \cos(nx)\quad(n=1,2,3,\dots)$
    - $\varphi_{2n}(x) = \sin(nx)\quad(n=1,2,3,\dots)$
  - $\left\{ \varphi_n \right\}_{n=0}^\infty$ は $[-\pi, \pi]$ 上で完全系な直行系となる
  - 以下証明？
    - $\displaystyle \int_\pi^\pi \cos(nx)\ dx = 0 \quad (n \neq 0)$
    - $\displaystyle \int_\pi^\pi \sin(nx)\ dx = 0 \quad (n \neq 0)$
      - この2つはまぁグラフを想像すればそれっぽい
    - 