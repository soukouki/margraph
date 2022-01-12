# ベクトルの回転

$$
\mathbf{\nabla} \times \mathbf{A}
= \left(
  \frac{\partial A_z}{\partial y} - \frac{\partial A_y}{\partial z},
  \frac{\partial A_x}{\partial z} - \frac{\partial A_z}{\partial x},
  \frac{\partial A_y}{\partial x} - \frac{\partial A_x}{\partial y}
  \right)
$$

x軸の計算はyとz、y軸の計算はzとx、z軸の計算はxとy、というふうに、求める軸と異なる2軸を使う。
分母と分子(微分だからちょっと違うが)でそれぞれ軸が異なっている。
分子を見ると、x軸はz->y、y軸はx->z、z軸はy->x、というふうに文字が続く。

多分こんなふうに覚えれば軸は間違えないはず・・・

ベクトルの発散とにているが、あっちは内積、こっちは外積
