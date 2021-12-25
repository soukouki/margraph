# チャーチ数

簡単さを求めるため、振る舞い等価なものは区別せずに考える。そのため、値呼び戦略ではなく、完全ベータ簡約で簡約している

$$
\begin{eqnarray}
c_0 &=& \lambda s.\ \lambda z.\ z\\
c_1 &=& \lambda s.\ \lambda z.\ s\ z\\
c_2 &=& \lambda s.\ \lambda z.\ s\ (s\ z)\\
c_3 &=& \lambda s.\ \lambda z.\ s\ (s\ (s\ z))\\
&\vdots&
\end{eqnarray}
$$

$\mathrm{succ}$ を $n$ 回適用するコンビネータで表現する

## succ

外側に1つ分追加するイメージ

$\mathrm{scc} = \lambda n.\ \lambda s.\ \lambda z\ s\ (n\ s\ z)$

`succ(2)`の例

$$
\begin{eqnarray}
\mathrm{scc}\ c_2
&=& (\lambda n.\ \lambda s.\ \lambda z\ s\ (n\ s\ z))\ c_2\\
&\to& \lambda s.\ \lambda z\ s\ (c_2\ s\ z)\\
&=& \lambda s.\ \lambda z.\ s\ ((\lambda s.\ \lambda z.\ s\ (s\ z))\ s\ z)\\
&\to& \lambda s.\ \lambda z.\ s\ (\lambda z.\ s\ (s\ z)\ z)\\
&\to& \lambda s.\ \lambda z.\ s\ (s\ (s\ z))\\
&=& c_3
\end{eqnarray}
$$

## succ(2)

内側に1つ分追加するイメージ

$\mathrm{scc'} = \lambda n.\ \lambda s.\ \lambda z.\ n\ s\ (s\ z)$

`succ'(2)`の例

$$
\begin{eqnarray}
\mathrm{scc'}\ c_2
&=& (\lambda n.\ \lambda s.\ \lambda z.\ n\ s\ (s\ z))\ c_2\\
&\to& \lambda s.\ \lambda z.\ c_2\ s\ (s\ z)\\
&=& \lambda s.\ \lambda z.\ (\lambda s.\ \lambda z.\ s\ (s\ z))\ s\ (s\ z)\\
&\to^\ast& \lambda s.\ \lambda z.\ s\ (s\ (s\ z))\\
&=& c_3
\end{eqnarray}
$$

## plus

$m, n$ が与えられて、$m$ の $z$ に $n$ を入れるイメージ

$\mathrm{plus} = \lambda m.\ \lambda n.\ \lambda s.\ \lambda z.\ m\ s\ (n\ s\ z)$

`1+2`の例

$$
\begin{eqnarray}
\mathrm{plus}\ c_1\ c_2
&=& (\lambda m.\ \lambda n.\ \lambda s.\ \lambda z.\ m\ s\ (n\ s\ z))\ c_1\ c_2\\
&\to^\ast& \lambda s.\ \lambda z.\ c_1\ s\ (c_2\ s\ z)\\
&=& \lambda s.\ \lambda z.\ c_1\ s\ ((\lambda s.\ \lambda z.\ s\ (s\ z))\ s\ z)\\
&\to^\ast& \lambda s.\ \lambda z.\ c_1\ s\ (s\ (s\ z))\\
&=&  \lambda s.\ \lambda z.\ (\lambda s.\ \lambda z.\ s\ z)\ s\ (s\ (s\ z))\\
&\to& \lambda s.\ \lambda z.\ (\lambda z.\ s\ z)\ (s\ (s\ z))\\
&\to& \lambda s.\ \lambda z.\ s\ (s\ (s\ z))\\
&=& c_3
\end{eqnarray}
$$

## times

$n$ を使って $n$ を足す関数を作り、それを $m$ に渡して $m$ 回実行してもらう

$\mathrm{times} = \lambda m.\ \lambda n.\ m\ (\mathrm{plus}\ n)\ c_0$

`2*2`の例

$$
\begin{eqnarray}
\mathrm{times}\ c_2\ c_2
&=& (\lambda m.\ \lambda n.\ m\ (\mathrm{plus}\ n)\  c_0)\ c_2\ c_2\\
&\to^\ast& c_2\ (\mathrm{plus}\ c_2)\ c_0\\
&=& (\lambda s.\ \lambda z.\ s\ (s\ z))\ (\mathrm{plus}\ c_2)\ c_0\\
&\to^\ast& (\mathrm{plus}\ c_2)\ (\mathrm{plus}\ c_2\ c_0)\\
&=& \mathrm{plus}\ c_2\ c_2\\
&\to^\ast& c_4
\end{eqnarray}
$$

## power

$\mathrm{times}$ の $\mathrm{plus}$ を $\mathrm{times}$ に置き換えたらうまくいきそう

$\mathrm{power} = \lambda m.\ \lambda n.\ m\ (\mathrm{times}\ n)\ c_1$

`2**3`の例

$$
\begin{eqnarray}
\mathrm{power}\ c_3\ c_2
&=& (\lambda m.\ \lambda n.\ m\ (\mathrm{times}\ n)\ c_1)\ c_3\ c_2\\
&\to^\ast& c_3 (\mathrm{times}\ c_2)\ c_1\\
&=& (\lambda s.\ \lambda z.\ s\ (s\ (s\ z)))\ (\mathrm{times}\ c_2)\ c_1\\
&\to^\ast& (\mathrm{times}\ c_2)\ ((\mathrm{times}\ c_2)\ (\mathrm{times}\ c_2\ c_1))\\
&\to^\ast& (\mathrm{times}\ c_2)\ (\mathrm{times}\ c_2\ c_2)\\
&\to^\ast& \mathrm{times}\ c_2\ c_4\\
&\to^\ast& c_8
\end{eqnarray}
$$

## iszero

$c_0$ のみ、そのまま $z$ を返すので、succは引数を受け取って、引数に関わらず $\mathrm{fls}$ を返す関数にすればよい

$\mathrm{iszro} = \lambda m.\ m\ (\lambda x.\ \mathrm{fls})\ \mathrm{tru}$

`iszero?(0)`の例

$$
\begin{eqnarray}
\mathrm{iszro}\ c_0
&=& (\lambda m.\ m\ (\lambda x.\ \mathrm{fls})\ \mathrm{tru})\ c_0\\
&\to^\ast& c_0\ (\lambda x.\ \mathrm{fls})\ \mathrm{tru}\\
&=& (\lambda s.\ \lambda z.\ z)\ (\lambda x.\ \mathrm{fls})\ \mathrm{tru}\\
&\to^\ast& \mathrm{tru}
\end{eqnarray}
$$

`iszero?(1)`の例

$$
\begin{eqnarray}
\mathrm{iszro}\ c_1
&=& (\lambda m.\ m\ (\lambda x.\ \mathrm{fls})\ \mathrm{tru})\ c_1\\
&\to^\ast& c_1\ (\lambda x.\ \mathrm{fls})\ \mathrm{tru}\\
&=& (\lambda s.\ \lambda z.\ s\ z)\ (\lambda x.\ \mathrm{fls})\ \mathrm{tru}\\
&\to^\ast& (\lambda x.\ \mathrm{fls})\ \mathrm{tru}\\
&\to^\ast& \mathrm{fls}
\end{eqnarray}
$$

## pred

succでは、2つ目の要素の値と、2つ目の要素値+1をペアにして渡していく。すると、$c_n$ のとき $\mathrm{pair}\ c_{n-1}\ c_n$ となるので、それを使う

$$
\begin{eqnarray}
z &=& \mathrm{pair}\ c_0\ c_0\\
s &=& \lambda p.\ \mathrm{pair}\ (\mathrm{snd}\ p)\ (\mathrm{plus}\ c_1\ (\mathrm{snd}\ p))\\
\mathrm{prd} &=& \lambda m.\ \mathrm{fst}\ (m\ s\ z)\\
\end{eqnarray}
$$

`pred(2)`の例

$$
\begin{eqnarray}
\mathrm{prd}\ c_2
&=& (\lambda m.\ \mathrm{fst}\ (m\ s\ z))\ c_2\\
&\to& \mathrm{fst}\ (c_2\ s\ z)\\
&=& \mathrm{fst}\ ((\lambda s.\ \lambda z.\ s\ (s\ z))\ s\ z)\\
&\to^\ast& \mathrm{fst}\ (s\ (s\ z))\\
&=& \mathrm{fst}\ (s\ (\lambda p.\ \mathrm{pair}\ (\mathrm{snd}\ p)\ (\mathrm{plus}\ c_1\ (\mathrm{snd}\ p))\ (\mathrm{pair}\ c_0\ c_0)))\\
&\to& \mathrm{fst}\ (s\ (\mathrm{pair}\ (\mathrm{snd}\ (\mathrm{pair}\ c_0\ c_0))\ (\mathrm{plus}\ c_1\ (\mathrm{snd}\ (\mathrm{pair}\ c_0\ c_0)))))\\
&\to^\ast& \mathrm{fst}\ (s\ (\mathrm{pair}\ c_0\ (\mathrm{plus}\ c_1\ c_0)))\\
&\to^\ast& \mathrm{fst}\ (s\ (\mathrm{pair}\ c_0\ c_1))\\
&=& \mathrm{fst}\ ((\lambda p.\ \mathrm{pair}\ (\mathrm{snd}\ p)\ (\mathrm{plus}\ c_1\ (\mathrm{snd}\ p)))\ (\mathrm{pair}\ c_0\ c_1))\\
&\to& \mathrm{fst}\ (\mathrm{pair}\ (\mathrm{snd}\ (\mathrm{pair}\ c_0\ c_1))\ (\mathrm{plus}\ c_1\ (\mathrm{snd}\ (\mathrm{pair}\ c_0\ c_1))))\\
&\to^\ast& \mathrm{snd}\ (\mathrm{pair}\ c_0\ c_1)\\
&\to^\ast& c_1
\end{eqnarray}
$$

`pred(0)`の例

$$
\begin{eqnarray}
\mathrm{prd}\ c_0
&=& (\lambda m.\ \mathrm{fst}\ (m\ s\ z))\ c_0\\
&\to& \mathrm{fst}\ (c_0\ s\ z)\\
&=& \mathrm{fst}\ ((\lambda s.\ \lambda z.\ z)\ s\ z)\\
&\to^\ast& \mathrm{fst}\ z\\
&=& \mathrm{fst}\ (\mathrm{pair}\ c_0\ c_0)\\
&\to^\ast& c_0
\end{eqnarray}
$$

## sub

timesやpowerと同じ様に、先程のpredを $n$ 回繰り返す

$\mathrm{sub} = \lambda m.\ \lambda n.\ n\ (\lambda x.\ pred x)\ m$

`3-2`の例

$$
\begin{eqnarray}
\mathrm{sub}\ c_3\ c_2
&=& (\lambda m.\ \lambda n.\ n\ (\lambda x.\ \mathrm{pred}\ x)\ m)\ c_3\ c_2\\
&\to^\ast& c_2\ (\lambda x.\ \mathrm{pred}\ x)\ c_3\\
&=& (\lambda s.\ \lambda z.\ s\ (s\ z))\ (\lambda x.\ \mathrm{pred}\ x)\ c_3\\
&\to^\ast& (\lambda x.\ \mathrm{pred}\ x)\ ((\lambda x.\ \mathrm{pred}\ x)\ c_3)\\
&\to& (\lambda x.\ \mathrm{pred}\ x)\ (pred\ c_3)\\
&\to^\ast& (\lambda x.\ \mathrm{pred}\ x)\ c_2\\
&\to& \mathrm{pred}\ c_2\\
&\to^\ast& c_1
\end{eqnarray}
$$

`1-2`の例

$$
\begin{eqnarray}
\mathrm{sub}\ c_1\ c_2
&=& (\lambda m.\ \lambda n.\ n\ (\lambda x.\ \mathrm{pred}\ x)\ m)\ c_1\ c_2\\
&\to^\ast& (\lambda x.\ \mathrm{pred}\ x)\ c_1\\
&=& (\lambda s.\ \lambda z.\ s\ (s\ z))\ (\lambda x.\ \mathrm{pred}\ x)\ c_1\\
&\to^\ast& ((\lambda x.\ \mathrm{pred}\ x)\ ((\lambda x.\ \mathrm{pred}\ x)\ c_1))\\
&\to& c_2\ ((\lambda x.\ \mathrm{pred}\ x)\ (\mathrm{pred}\ c_1))\\
&\to^\ast& ((\lambda x.\ \mathrm{pred}\ x)\ c_0)\\
&\to& \mathrm{pred} c_0\\
&\to& c_0
\end{eqnarray}
$$

## equal

引いてiszeroで調べれば終わり・・・と思いきや、引く数のほうが多いと失敗します。とりあえずandで誤魔化します

$\mathrm{equal} = \lambda m.\ \lambda n.\ \mathrm{and}\ (\mathrm{iszro}\ (\mathrm{sub}\ m\ n))\ (\mathrm{iszro}\ (\mathrm{sub}\ n\ m))$

`1==2`の例

$$
\begin{eqnarray}
\mathrm{eqaul}\ c_1\ c_2
&=& (\lambda m.\ \lambda n.\ \mathrm{and}\ (\mathrm{iszro}\ (\mathrm{sub}\ m\ n))\ (\mathrm{iszro}\ (\mathrm{sub}\ n\ m)))\ c_1\ c_2\\
&\to^\ast& \mathrm{and}\ (\mathrm{iszro}\ (\mathrm{sub}\ c_1\ c_2))\ (\mathrm{iszro}\ (\mathrm{sub}\ c_2\ c_1))\\
&\to^\ast& \mathrm{and}\ (\mathrm{iszro}\ c_0)\ (\mathrm{iszro}\ c_1)\\
&\to^\ast& \mathrm{and\ tru\ fls}\\
&\to^\ast& \mathrm{fls}
\end{eqnarray}
$$
