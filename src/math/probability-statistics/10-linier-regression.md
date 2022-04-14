# 線形回帰

- 授業で扱った、最小二乗法を用いた線形回帰について
- $a$ を変形していくと、$\dfrac{C_{XY}}{S_X^2}$ となる
  - $C_{XY}$ は測定値 $x_i$ と $y_i$ の共分散
  - $S_X$ は測定値 $x_i$ の分散

## 計算方法
- $\displaystyle L = \sum_{i=1}^N (\bar y_i - y_i)^2 = \sum_{i=1}^N (a x_i + b - y_i)^2$ が最小になるように $a$ と $b$ を求める
- 2次関数であれば、微分が0になる場所が最大値/最小値になる
- $\displaystyle L = \sum (a^2 x_i^2 + b^2 + y_i^2 + 2 a b x_i - 2 b y_i - 2 a x_i y_i)$
- $\displaystyle L = a^2 \sum x_i^2 + N b^2 + \sum y_i^2 + 2ab \sum x_i - 2b \sum y_i - 2a \sum x_i y_i$
- ところで、$\sum x_i^2, \sum y_i^2$ は観測結果から分かるので、これは $a$ と $b$ の2次関数となる
  - TODO : 2変数の2次関数わからん
- 最小値を求めるためにbで微分すると、
  - $\displaystyle \dfrac{\partial L}{\partial b} = 2Nb + 2a \sum x_i - 2 \sum y_i = 0$
  - $b = \dfrac{\sum y_i - a \sum x_i}{N}$
  - $b = \bar y_i - a \bar x_i$
- aも求める必要があるので、そちらも微分して
  - $\displaystyle  \dfrac{\partial L}{\partial a} = 2a \sum x_i^2 + 2b \sum x_i - 2b \sum x_i y_i = 0$
  - ここでbを入れたりと、少しギャップがある
  - $a = \dfrac{\displaystyle \sum x_i y_i - N \bar x_i \bar y_i}{\displaystyle \sum x_i^2 - N \bar x_i^2}$
    - $\sum x_i = N \bar x$ と見る