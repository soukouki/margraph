# 仮説検定の例

- 仮説検定の例
- ある制作に対する支持率を調べるために、10,000人にウェブアンケートを行った。
- そのうち、4000人が支持すると答えた
- 「支持率が50%以上」という帰無仮説($H_0$)を棄却したい
- 有意水準は1%
- 支持するかしないかの2択なので、二項分布として評価する
- $Z=\dfrac{4000-5000}{\sqrt{10000 \times 0.5 \times 0.5}} = -20$ (!?)
  - 平均の分散とか見ると・・
- 明らかにこれが出る確率は低すぎるので、「支持率が50%以上」という帰無仮説は棄却される
- つまり、「支持率が50%以下」という結果になる
