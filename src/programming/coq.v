From mathcomp
  Require Import ssreflect.

Section ModusPones.

Variables X Y : Prop.
Hypothesis XtoY_is_true : X -> Y.
Hypothesis X_is_true : X.
(* PならばQを証明するということは、Pが成り立つことを仮定したときに、QからPが出てくればよい *)

Theorem MP: Y.

Proof.
move: X_is_true.
move: X_is_true.
(* move: を使うと、X_is_true -> もとのやつ みたいな動き方をする (* X->X->Y は X->(X->Y)なことに注意 *) *)
move=> X_is_true_again.
(* move=> を使うと、P -> Q のときにPを上にやれる *)
(* :と=>のタクティカルの使い分けは、あとで出てくるcaseとかのタクティックでも同じ *)
by [].
(* by は、順番に適用していって、最後に自明になればgoalを消す、みたいな役割をする *)
(* 今回は仮定と同じになって明らかに成り立つので、by []. で終わりにできる *)
(* move: X_is_true. を使わずとも、by move: X_is_true. だけで証明はできる *)
Qed.

End ModusPones.
