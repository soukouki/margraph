# カリー化

複数の引数を取る関数を、高階関数に変換すること

例えば、$f = \lambda(x, y).\ s$ のような複数の引数を取る関数があるとき、$f(v,w) = (\lambda y.\ [x\mapsto v]s)\ w = [y\mapsto w][x\mapsto v]s $ と変換していくこと
