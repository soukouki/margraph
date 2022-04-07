# mkdirで連番ディレクトリを作る

```sh
$ mkdir ex{1..14}
$ ls
ex1  ex10  ex11  ex12  ex13  ex14  ex2  ex3  ex4  ex5  ex6  ex7  ex8  ex9
```

0埋めする場合は
```sh
$ mkdir ex{01..14}
$ ls
ex01  ex02  ex03  ex04  ex05  ex06  ex07  ex08  ex09  ex10  ex11  ex12  ex13  ex14
```
