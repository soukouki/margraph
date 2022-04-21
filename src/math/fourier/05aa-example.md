# $\{cos nx\}_{n=1}^\infty$ は $[0, \pi]$ で直交関数系である

- 次の2つを示せれば、直交関数系だとわかる
  - $n \neq m$ のとき $\int \cos nx \cos mx\ dx = 0$
    - $$
      \begin{eqnarray}
      \int_0^\pi \cos nx \cos mx\ dx &=& \int_0^\pi \dfrac{1}{2} \big\{ \cos \left( nx+mx \right) + \cos \left( nx-mx \right) \big\} dx \\
      &=& \dfrac{1}{2} \int_0^\pi \big\{ \cos (n+m) x + \cos (n-m) x \big\}\ dx \\
      &=& \dfrac{1}{2} \left[ \dfrac{sin(n+m) x}{n+m} + \dfrac{sin(n-m) x}{n-m} \right]_0^\pi \\
      &=& 0
      \end{eqnarray}
      $$
    - 三角関数の和積公式で変換
    - $\sin(0) = \sin(\pi) = 0$
  - $\int \cos^2 nx\ dx = a_n$
    - $$
      \begin{eqnarray}
      \int_0^\pi \cos^2 nx\ dx &=& \int_0^\pi \dfrac{1}{2} ( \cos 2nx + \cos 0 ) dx \\
      &=& \dfrac{1}{2} \int_0^\pi ( \cos 2nx + 1 )\ dx \\
      &=& \dfrac{1}{2} \left[ \dfrac{\sin 2nx}{2n} + \pi \right]_0^\pi \\
      &=& \dfrac{\pi}{2}
      \end{eqnarray}
      $$       
    - 同じく三角関数の和積公式と、$\sin(0) = \sin(\pi) = 0$で変形
