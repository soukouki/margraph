# 必要呼び戦略

Haskellは必要呼びとして、名前呼び戦略を使っている。
その際、二回目以降に再評価しなくて済むようにしているので、実際は抽象構文木上ではなく、抽象構文グラフ上での簡約関係になる
