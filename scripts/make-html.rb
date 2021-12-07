
require 'kramdown'

require './scripts/utility'

target_file = ARGV[0]

root_dir_path = root_dir_path(target_file)

text = open('tmp/'+target_file+'.md', 'r'){|io|io.read}

title = text.match(/\#\s+(.+)/)&.[](1) || text.match(/(.+)\n=====/)&.[](1) || '無題'

body = Kramdown::Document.new(text)
  .to_html
  .gsub(/(?<!>|\s)\n(?!<|\s)/){|s|$stderr.puts "*"*100; $stderr.puts s; $stderr.puts "*"*100; '<br>'} # タグに挟まれていたりする改行をbrタグに置き換え
  .gsub(/(?<=>)(\u00A0)(?=<\/th>)/){''} # tableで項目を入れないときに出てくるゼロ幅スペースを削除
  .gsub(/(^|(?!>))    /, "") # Kramdownでcodeブロック内が置き換えられてしまうのでつけていた空白を削除

html_base = open('base.html', 'r').read

puts html_base.gsub(/\{\{(.+)\}\}/){eval($1)}