
# 文字列検索では、速度を考えずに書くことにします。
#
# ページの量が多くなり、この部分がネックになったころに、きちんとしたアルゴリズム(ラビン・カープ法)を使うか、C言語に置き換えます。
# 理由としては、Rubyの遅さや、タイトルの文字列の長さの長短によって、きちんとしたアルゴリズムを使うメリットが薄れているためです。

require "yaml"

require "./scripts/utility"

src_files = ARGV

index = YAML.load_file('tmp/merged_article_list.yaml')

result = src_files
  .map do |src_file|
    src = open("src/#{src_file}.md", "r") do |io|
      io.readline # 最初の行は読み飛ばす
      io.read
    end
      .gsub(/\s+/, " ")
    root_dir_path = root_dir_path(src_file[4..-1]) # src/...
    matches = index[:files]
      .flat_map do |item|
        title = item[:title]
        Enumerator
          .new do |y|
            i = 0
            loop do
              res = src.index(title, i)
              break if res.nil?
              y << res
              i = res + title.length
            end
          end
          .map do |i|
            {
              text: title,
              path: item[:path],
              surrounding_text: src[[0, i-10].max..[src.length, i+title.length+10].min],
              index: i
            }
          end
      end
      .sort_by{|h|h[:index]}
    [src_file, matches]
  end
  .to_h

result.to_yaml.display
