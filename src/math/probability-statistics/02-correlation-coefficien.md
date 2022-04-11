# 相関係数

- 相関の度合いを測る係数
  - 正なら正の相関
  - 負なら負の相関
- $\displaystyle r_{xy} = \frac{\sum_{i=1}^N (x_i - \bar x)(y_i - \bar y)}{N} \bigg / \sqrt{\frac{\sum_{i=1}^N (x_i - \bar x)^2}{N}} \sqrt{\frac{\sum_{i=1}^N (y_i - \bar y)^2}{N}}$
  - $\bar x$ はxの平均, $\bar y$ も同様
  - $N$ はサンプルサイズ(データ数)
- $r_{xy} = \dfrac{C_{xy}}{S_x S_y}$
  - $C_{xy}$ は共分散(covariance)
  - $S_x$ はxの標準偏差
  - $S_X^2$ はxの標本分散
- $\dfrac{\sum_{i=1}^N (x_i - \bar x)(y_i - \bar y)}{N} = C_{xy}$ の $x_i$ と $y_i$ は、場合によってすごく大きくなったり、小さくなったりする(身長と所持金とかみたいに)
  - それをいい感じに抑えるために $S_x$ と $S_y$ を使う
