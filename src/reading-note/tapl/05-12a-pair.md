# ラムダ計算のペア

$$
\begin{eqnarray}
\mathrm{pair} &=& \lambda f.\ \lambda s.\ \lambda b.\ b\ f\ s\\
\mathrm{fst} &=& \lambda p.\ p\ \mathrm{tru}\\
\mathrm{snd} &=& \lambda p.\ p\ \mathrm{fls}\\
\end{eqnarray}
$$

チャーチブール数を使うと短く実装できる
