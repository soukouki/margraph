# 型なし算術式

型なしブール式を拡張した形だと考える

## 注意して見るポイント

- $nv$ の扱い
  - $nv$ は $0$ か $\mathrm{succ}\ nv$になる
  - 例えば $\mathrm{succ\ pred}\ 0$ は $nv$ にはならない
  - 多分だけど、計算の順序を一意にするためにある気がする
- なぜ $\mathrm{prev}\ 0 \to 0$ なのか
  - 要するに、マイナスの状態を許容しない理由
  - つまり、なぜ $nv ::= 0, \mathrm{succ}\ nv, \mathrm{pred}\ nv$ ではないのか
  - E-SuccとE-Predがあるのだから、上のものがあってもいいはず。
  - 評価の順序を一意にするため？
    - E-PredSuccに加えて、E-SuccPredが必要になるはずで
    - $\mathrm{succ_1\ pred_2\ succ_3}\ 0$ があったとき
      - E-SuccPredを使って $\mathrm{succ_3}\ 0$
        - $1-1+1+0 \to (1-1)+1+0 \to 1+0$ みたいな感じ
      - E-SuccとE-PredSuccを使って $\mathrm{succ_1}\ 0$
        - $1-1+1+0 \to 1+(-1+1)+0 \to 1+0$ みたいな感じ

項が正規形であるが値でないとき、その項は行き詰まり状態となる
