Inductive bool : Type :=
  | true
  | false.

Definition negb (b:bool) : bool :=
  match b with
  | true => false
  | false => true
  end.

Definition andb (b1:bool) (b2:bool) : bool :=
  match b1 with
  | true => b2
  | false => false
  end.

Definition orb (b1:bool) (b2:bool) : bool :=
  match b1 with
  | true => true
  | false => b2
  end.

Notation "x && y" := (andb x y).
Notation "x || y" := (orb x y).

Example test_andb_orb5 : false && true || true = true.
Proof. simpl. reflexivity. Qed.
Example test_andb_orb7 : false && false || true = true.
Proof. simpl. reflexivity. Qed.

Example test_andb_orb14 : false || true && false = false.
Proof. simpl. reflexivity. Qed.
Example test_andb_orb15 : false || false && true = false.
Proof. simpl. reflexivity. Qed.
