# Vivaldiでダークテーマを使う

- 右往左往したのでメモ
- 拡張機能を入れる必要がある
  - 公式ヘルプでそっちに案内しているので、標準機能にはついてないのだと思われる
    - テーマごとに設定できたら、昼と夜でテーマを使い分けられて面白いのに
    - https://help.vivaldi.com/ja/desktop-ja/appearance-customization-ja/browser-themes/#uebupejinodakumodo
  - うちはオープンソースのものを使いたかったので、Dark Readerを使うことに
    - https://chrome.google.com/webstore/detail/dark-reader/eimadpbcbfnmbkopoojfekhnkhdbieeh?hl=ja
    - https://github.com/darkreader/darkreader
- 失敗したやり方のメモ
  - Windowsのときみたく、OS側の設定を探した
    - `gsettings set org.gnome.desktop.interface gtk-theme "Adwaita-dark"`
    - https://wiki.archlinux.org/title/Dark_mode_switching の、gsettingsのコマンドを使うとFireFoxは切り替わった
      - vivaldiは上手く行かなかった
      - 日本語版の方は情報が古いのか、gsettingsのコマンドは載ってなかった
        - https://wiki.archlinux.jp/index.php/%E3%83%80%E3%83%BC%E3%82%AF%E3%83%A2%E3%83%BC%E3%83%89%E3%81%AE%E5%88%87%E3%82%8A%E6%9B%BF%E3%81%88
- ArchLinux + i3 で、の1例として・・・
  - GUI環境がどうレイヤが重なってるのか把握できてないので、あくまでやってみた系の記事として
