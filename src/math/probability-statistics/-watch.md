# 確率統計用のwatch

- watchコマンドで、ファイルを編集した直後にブラウザで見れるようにする
  - LaTeXの結果をすぐに見れて便利
- `watch -n 0.1 'make -sj $(ls src/math/probability-statistics/*.md | sed -r "s/src(.+)\.md/public\1.html/") public/math/probability-statistics/index.html'`
  - margraphフォルダで実行するように
