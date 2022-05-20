# pacmanを通して自作のライブラリを実行する

- 自身で作ったソフトをpathに通したい
  - けれど、どこに置けばいいのかお作法もわからない
- pacmanでインストールする形式にすれば悩む必要もない！
- makepkgを使ってパッケージ化する
  - ArchWiki: https://wiki.archlinux.jp/index.php/Makepkg
    - 基本的には`makepkg`コマンドをそのまま実行するだけで、`PKGBUILD`ファイルが本体
  - PKGBUILDの例: https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=pulseaudio-virtualmic
    - シンプルな構成の例として勧められた
  - パッケージ名とソフトの名前が同じだと失敗するので、ソフトを`${pkgdir}/bin`に置くようにした
    - それに応じて`PKGBIULD`ファイルを修正した
- pacmanを使って作ったパッケージをインストールする
  - `sudo pacman -U <makepkgで作ったパッケージファイルのパス>`
  - 今回はAURへの公開はしなかった
