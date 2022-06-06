# margraphで編集したときに自動で反映するワンライナー

```bash
dir=$(pwd); while true; do list=$(inotifywait . -e modify -q | awk '{print($3)}' | sed -r '$a index.md' | sed -r 's/(.+).md/public\/math\/fourier\/\1.html/' | sed -z -e 's/\n/ /'); cd ../../..; make -j $(echo $list); cd $dir; done
```

- inotifywaitで変更を監視して、それに合わせてmakeを実行する
- パスの指定が雑だけど許して
- シェルのワンライナー
