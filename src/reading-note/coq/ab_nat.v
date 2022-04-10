Inductive nat : Type :=
  | O
  | S (n : nat).

Definition pred (n : nat) : nat :=
  match n with
    | O => O
    | S n' => n'
  end.

Example test_pred1 : pred (S (S (S O))) = S (S O).
Proof. simpl. reflexivity. Qed.

Fixpoint evenb (n:nat) : bool :=
  match n with
  | O => true
  | S O => false
  | S (S n') => evenb n'
  end.

Example test_evenb1 : evenb (S (S O)) = true.
Proof. simpl. reflexivity. Qed.
Example test_evenb2 : evenb (S (S (S O))) = false.
Proof. simpl. reflexivity. Qed.

Definition oddb (n:nat) : bool := negb (evenb n).

Example test_oddb1: oddb (S O) = true.
Proof. simpl. reflexivity. Qed.
Example test_oddb2: oddb (S (S (S (S O)))) = false.
Proof. simpl. reflexivity. Qed.

Fixpoint plus (n : nat) (m : nat) : nat :=
  match n with
    | O => m
    | S n' => S (plus n' m)
  end.

Example test_plus1: (plus (S (S (S O))) (S (S O))) = S (S (S (S (S O)))).
Proof. simpl. reflexivity. Qed.

Fixpoint mult (n m : nat) : nat :=
  match n with
    | O => O
    | S n' => plus m (mult n' m)
  end.

Example test_mult1: (mult (S (S O)) (S (S O))) = S (S (S (S O))).
Proof. simpl. reflexivity. Qed.

Fixpoint ltb (n m : nat)