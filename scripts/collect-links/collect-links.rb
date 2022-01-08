
# 文字列検索では、速度を考えずに書く
#
# ページの量が多くなり、この部分がネックになったころに、きちんとしたアルゴリズム(ラビン・カープ法)を使うか、C言語に置き換える
# Rubyでアルゴリズム書いたところで遅いので、標準ライブラリを適当に使うほうが楽だから

require "json"

collect_path = ARGV[0]

articles = JSON.load_file("tmp/merged-articles.json")

src_files = Dir["src/#{collect_path}/*.md"]

result = src_files
  .map do |src_file|
    src = open(src_file, "r") do |io|
      io.readline # 最初の行は読み飛ばす
      io.read
    end
      .gsub(/\s+/, " ")
    root_dir_path = "../"*collect_path.count("\/")
    path = if collect_path.empty?
      File.basename(src_file, ".md")
    else
      collect_path+"/"+File.basename(src_file, ".md")
    end
    matches = articles["files"]
      .flat_map do |match_path, article|
        next [] if match_path == path
        title = article["title"]
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
              title: title,
              path: match_path,
              surrounding_text: src[[0, i-10].max..[src.length, i+title.length+10].min],
              index: i
            }
          end
      end
      .sort_by{|h|h[:index]}
      .inject([]) do |list, article|
        next [article] if list.empty?
        last = list.last
        next list.push [list.pop, article].max_by{|i|i[:title].length} if last[:index] == article[:index]
        next list if last[:index] + last[:title].length >= article[:index]
        list.push article
      end
      .map do |article|
        {
          title: article[:title],
          path: article[:path],
          surrounding_text: article[:surrounding_text]
        }
      end
    [path, matches]
  end
  .to_h

open("tmp/#{collect_path}/link-network.json", "w"){|io|io.puts JSON.dump(result)}
