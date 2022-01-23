# スタック

last-in, first-out(LIFO)

例えば平積みされた本のようなもので、一番上に要素を追加したり、一番上の要素を取り出したりできる。

- 要素の追加/push
- 要素の吐き出し/pop

実装方法は片方向連結リストや、配列(最後の要素のアドレスを保持しておくだけ)。

関数を呼び出すときのスタックとかで常に使われてる。スタックオーバーフローのスタックはこいつ。(正確には関数呼び出しで使うスタック)