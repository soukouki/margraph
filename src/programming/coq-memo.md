# Coqの証明メモ

- Coqで証明するときに使えるテクニックなど
- 証明事例集
  - https://magicant.github.io/programmingmemo/coq/#casestudy
  - にある証明事例集はめっちゃ使える
- boolよりも、Propで計算するほうが、`by [].`とかの自動推論がよく効いて楽
  - boolで書いたら数十行なのが、Propだと`by [].`で終わることもある
- suffとhaveを使って、証明の方向性を管理していくのが良さそう
  - チェックポイントとしても使えるし、中間から証明をしていくほうが楽なことも多々ある
