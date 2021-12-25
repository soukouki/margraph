# チャーチブール数

## trueとfalse

$$
\begin{eqnarray}
\mathrm{tru} &=& \lambda t.\ \lambda f.\ t\\
\mathrm{fls} &=& \lambda t.\ \lambda f.\ f
\end{eqnarray}
$$

## test

$\mathrm{test} = \lambda l.\ \lambda m.\ \lambda n.\ l\ m\ n$

$\mathrm{test}\ b\ v\ w$ は、$b$ が $\mathrm{tru}$ のとき $v$ へ簡約され、$\mathrm{fls}$ のとき $w$ へ簡約される

## and

$\mathrm{and} = \lambda b.\ \lambda c.\ b\ c\ fls$

`true and false`の例

$$
\begin{eqnarray}
\mathrm{and\ tru\ fls} 
&=& (\lambda b.\ \lambda c.\ b\ c\ \mathrm{fls})\ \mathrm{tru\ fls}\\
&\to& (\lambda c.\ \mathrm{tru}\ c\ \mathrm{fls})\ \mathrm{fls}\\
&\to& \mathrm{tru\ fls\ fls}\\
&=& (\lambda t.\ \lambda f.\ t)\ \mathrm{fls\ fls}\\
&\to& (\lambda f.\ \mathrm{fls})\ \mathrm{fls}\\
&\to& \mathrm{fls}
\end{eqnarray}
$$

値呼び出し戦略によって、内部の抽象よりも $c$ が先に簡約される

## or

$\mathrm{tru}$ は前側、$\mathrm{fls}$ は後側の値を返すので、それを利用していい感じに組んでいけばいい

$\mathrm{or} = \lambda b.\ \lambda c.\ b\ \mathrm{tru}\ c\ \mathrm{tru\ fls}$

`false or true`の例

$$
\begin{eqnarray}
\mathrm{or\ fls\ tru}
&=& (\lambda b.\ \lambda c.\ b\ \mathrm{tru}\ c\ \mathrm{tru\ fls})\ \mathrm{fls\ tru}\\
&\to^\ast& \mathrm{fls\ tru\ tru\ tru\ fls}\\
&\to^\ast& \mathrm{tru\ tru\ fls}\\
&\to^\ast& \mathrm{tru}
\end{eqnarray}
$$

## not

$\mathrm{test}\ b\ \mathrm{fls\ tru}$ と考えれば良い

$\mathrm{not} = \lambda b.\ b\ \mathrm{fls\ tru}$

`not true`の例

$$
\begin{eqnarray}
\mathrm{not\ tru}
&=& (\lambda b.\ b\ \mathrm{fls\ tru})\ \mathrm{tru}\\
&\to& \mathrm{tru\ fls\ tru}\\
&\to^\ast& \mathrm{fls}
\end{eqnarray}
$$

`not false`の例

$$
\begin{eqnarray}
\mathrm{not\ fls}
&=& (\lambda b.\ b\ \mathrm{fls\ tru} \mathrm{fls}\\
&\to& \mathrm{fls\ fls\ tru}\\
&\to^\ast& \mathrm{tru}
\end{eqnarray}
$$
