# 条件付き確率の積分

- $g(x\|y) = P(X=x\|Y=y)$ とおく
- $\int g(x\|y)\ dx = 1$ となる
  - 条件付き確率でも、それを足し合わせると1となる
  - 直感的には、$f_{XY}(x,y) \to f(y)$ となり、分母と等しくなる
    - すべてのxについて見ていくのだから、結局すべてのyも集められていく
- $\int g(x\|y)h(y)\ dy = h(x)$ となる
  - $h(x) = P(X=x)$ とおく
  - 周辺確率を求めている
- 周辺確率とどう違うの？
