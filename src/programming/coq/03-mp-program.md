# プログラムを用いた定理証明

では実際に、カリー・ハワード同型対応を使い、プログラムを用いて命題を証明してみたいと思います。

## 例1. モーダスポネンス

今回は、PならばQであるならば、PならばQという命題を証明します。もっと具体的な例で表すならば、`雨が降っていれば家にいる`(PならばQ)と`[雨が降っている]`(P)という2つを仮定し、`[家にいる]`(Q)という結論を導き出すような命題です、xならばyを、数式で用いられる $x \to y$ と言う形で表すと、先ほどの命題は次のように表せます。

$$(P \to Q) \to P \to Q$$

この命題を証明するために、以下のようなプログラムを書きます(例はHaskellで書いていますが、TypeScript、Scala、Rustなど、多くの言語でも同じように証明できます)。

```haskell
modusPonens :: (p -> q) -> p -> q
modusPonens hpq hp = hpq hp
```

このとき、型は以下のようになります。(`x -> y` は、x型を引数に取り、y型を返す関数を表します。)

|変数|型|型の意味|
|:--:|:--:|:--:|
|`hpq`|`p -> q`|$P \to Q$|
|`hp`|`p`|$P$|
|`hpq hp`|`q`|$Q$|
|`modusPonens`|`(p -> q) -> p -> q`|$(P \to Q) \to P \to Q$|

`hpq hp`では、`p -> q`という型の関数に対して、`p`型の値を引数として渡しています。すると関数は`q`型の値を返します。

型で使われている`p`や`q`は、任意の型を表すもので、型引数と呼ばれます。C++やJavaのテンプレートと同じようなものです。

## 例2. 論理積

カリー・ハワード同型対応において、論理積は直積型(タプルや構造体)に対応します。

例えば、$P \to Q \to P \land Q$ は、以下のプログラムで証明できます。

```haskell
and :: p -> q -> (p, q)
and hp hq = (hp, hq)
```

$P \land Q \to P$ と $P \land Q \to Q$ も次のように証明できます。

```haskell
and_l :: (p, q) -> p
and_l (hp, _) = hp

and_r :: (p, q) -> q
and_r (_, hq) = hq
```

## 例3. 論理和

論理和は、直和型に対応します。今回は`Either`型を用いて証明します。

$P \to P \lor Q$ と $Q \to P \lor Q$ は、以下のように証明できます。

```haskell
or_introl :: p -> Either p q
or_introl hp = Left hp

or_intror :: q -> Either p q
or_intror hq = Right hq
```

## 例4. 否定

命題Pの否定 $\lnot P$ は、$P \to \bot$ という形で表されます。

ボトム型 $\bot$ は、どんな値も存在しない型です。例えば、`Int`型には値`1`が、`()`型には値`()`が存在しますが、ボトム型には値が存在しません。Haskellでは`Data.Void`のVoid型に対応します。

```haskell
import Data.Void

and_not :: (p -> Void) -> ((p, q) -> Void)
and_not hnp = hnp . and_l
```

型は以下のようになります。

|式|型|型の意味|
|:--:|:--:|:--:|
|`hnp`|`p -> Void`|$\lnot P$|
|`and_l`|`(p, q) -> p`|$P \land Q \to P$|
|`hnp . and_l`|`(p, q) -> Void`|$\lnot (P \land Q)$|
|`and_not`|`((p -> Void) -> ((p, q) -> Void))`|$\lnot P \to \lnot (P \land Q)$|

## 例5. ド・モルガンの法則

場合分けを用いてド・モルガンの法則の一部である $\lnot P \lor \lnot Q \to \lnot (P \land Q)$ を証明します。

```haskell
deMorgan :: (Either (p -> Void) (q -> Void)) -> ((p, q) -> Void)
deMorgan (Left hnp) = hnp . and_l
deMorgan (Right hnq) = hnq . and_r
```

仮定にある $\lnot P \lor \lnot Q$ に対して、$\lnot P$ の場合と $\lnot Q$ の場合に場合分けを行っています。場合分けはHaskellのパターンマッチに相当します。

型は以下のようになります。

|式|型|型の意味|
|:--:|:--:|:--:|
|`hnp`|`p -> Void`|$\lnot P$|
|`and_l`|`(p, q) -> p`|$P \land Q \to P$|
|`hnp . and_l`|`(p, q) -> Void`|$\lnot (P \land Q)$|
|`hnq`|`q -> Void`|$\lnot Q$|
|`and_r`|`(p, q) -> q`|$P \land Q \to Q$|
|`hnq . and_r`|`(p, q) -> Void`|$\lnot (P \land Q)$|
|`deMorgan`|(省略)|$\lnot P \lor \lnot Q \to \lnot (P \land Q)$|

ここまでプログラムを用いた定理証明を紹介しましたが、Coqではこれをタクティックと呼ばれるものを使い、抽象的に記述します。他の定理証明支援系でも同様の機能があります。

TODO: 練習問題少し追加するほうが良いかも