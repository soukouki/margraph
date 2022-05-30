# 区間推定

- ある一点の値を推定する(点推定)に対して、ある区間に入る確率が何%なのか、という形で推定する
- $P(L \leq \theta \leq U) \geq 1 - \alpha$
  - 与えられた $\alpha$ が保証する、真の母数の入る区間 L, U を推定する
  - $L$ を下側信頼限界
  - $U$ を上側信頼限界
  - $1-\alpha$ は信頼係数
- たまに、決めた $\alpha$ と L, U に収まるまで何回も試すような推定をすることがあり、Pハッキングと呼ばれる
- 例えば、$\alpha = 0.05, L = 10, U = 20$ としたとき、95%の確率で $L \leq \theta \leq U$ となる
- $Z = \dfrac{\bar x - \mu}{\sqrt{\sigma^2 / n}}$
  - 中心極限定理から正規分布なのがわかるから、こんな式になるのかな・・？
  - 変形すると、区間は $[\bar X - Z_{\small \dfrac{\alpha}{2}}\dfrac{\sigma}{\sqrt{n}}, \bar X + Z_{\small  \dfrac{\alpha}{2}}\dfrac{\sigma}{\sqrt{n}}]$ になる

## 例

1. 仮に $\alpha = 0.05$ とする
2. 正規分布表を見ると、$0.025$ の面積になる確率は $U=1.96$(標準得点)、$L=-1.96$
3. 母平均 $\mu$ の値を求める
    - $-1.96 \leq Z = \dfrac{\bar x - \mu}{\sqrt{\sigma^2 / n}} \leq 1.96$
    - $\bar x, n, \sigma^2$ がわかっているとしたら、$\mu$ の値が求められる
