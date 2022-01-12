# ガウスの法則

クーロンの法則から導かれた物理法則

微分形と積分形があるらしい

## 微分形のガウスの法則

$$
\mathbf{\nabla}\cdot\mathbf{E}(\mathbf{r}) =
\begin{cases}
0 & (\text{電荷が点 $\mathbf{r}$ にない場合}) \\
\dfrac{\rho(\mathbf{r})}{\varepsilon_0} & (\text{電荷が点 $\mathbf{r}$ にある場合})
\end{cases}
$$

ベクトルの発散を思い出すと、電場の湧き出し・染み込みと電荷密度の関係を表す公式なのがわかる。

ベクトルの発散さえわかれば、積分形のガウスの法則より直感的に思える。

特定の点のやつだから $\rho$

## 積分形のガウスの法則

$$
\int_S \mathbf{E} \cdot \mathbf{n}\ dS =
\begin{cases}
0 & (\text{電荷がSの外側にある場合}) \\
\dfrac{q}{\varepsilon_0} & (\text{電荷がSの内側にある場合})
\end{cases}
$$

面で囲った部分において、そこから出てくるベクトル場と電荷密度の関係を表す公式なのがわかる。

面を積分してるから積分形なのかな？

範囲の内側の電荷量だから $q$
