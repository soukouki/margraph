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

`tmp/<path>/attached-files.json`

`aaa.md`に`aaa.png`と`aaa1.test.python`が添付される場合

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
      "extension": "python",
      "type": "text"
    }
  ]
}
```

マージしたあとでMake Dependenceで使う
