# キュー

first-in, first-out(FIFO)

スタックと違い、ところてんだったり、お店の行列のような形をしている。

- 要素の追加/enqueue
- 要素の吐き出し/dequeue

実装方法は双方向連結リストや配列(最初の要素と最後の要素がつながっていると考えて、配列の長さを使い切ったら前に戻るようにする)

スレッドのキューなんかで使われてる(スタックと違い、前に追加した要素から実行されるので、前に追加したタスクが延々と実行されない、ということが防げる)。
