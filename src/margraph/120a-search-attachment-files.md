# Search Attachment Files

margraphの添付ファイルに必要なデータを収集して、添付ファイルを生成するために必要なデータを生成する。

ディレクトリごとに実行

## 入力

### ファイル

- `src/<path>`のすべてのファイル

### コマンドライン

- 調査をするディレクトリのパス

## 出力

### ファイル

`tmp/<path>/attachments-files.json`

`aaa.md`に`aaa.png`と`aaa1.test.python`が添付される場合

またバイナリファイルかテキストファイルかを判別して、バイナリファイルの場合は読み込まないようにする

```json
{
  "aaa": [
    {
      "path": "aaa",
      "extension": "png",
      "type": "image"
    },
    {
      "path": "aaa1.test",
      "extension": "py",
      "type": "text"
    }
  ]
}
```

マージしたあとでMake Dependenceで使う
