# 確率の例

||熱がある($B_1$)|熱がない($B_2$)|小計|
|:--|--:|--:|--:|
|風邪である($A_1$)|4|1|5|
|風邪でない($A_2$)|2|13|15|
|小計|6|14|20|

- $P(A_1) = \dfrac{\|A_1\|}{\Omega}=\dfrac{5}{20}$
  - 風邪である確率
- $P(A_1 \cap B_1) = \dfrac{\|A_1 \cap B_1\|}{\|\Omega\|} = \dfrac{4}{20}$
  - 風邪であり、かつ熱がある確率
  - 同時確率
- $P(A_1\|B_1) = \dfrac{\|A_1 \cap B_1\|}{\|B_1\|} = \dfrac{4}{6}$
  - 条件付き確率
  - 熱がある人の中で、風を引いている人の確率
  - 分母に注意！
    - 縦棒の右側と左側で、大きく意味が異なるので注意(どっちがどっちかわからなくなる)
