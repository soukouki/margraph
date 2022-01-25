
require "json"

path = ARGV[0]

source_files = Dir["src/#{path}/*.md"].map{|p|p.gsub("//","/")}

files = source_files
  .map do |file_path|
    title = open(file_path, 'r'){|io|io.readline}.chomp.sub(/^#\s+/, '')
    [
      file_path.gsub(/src\/(.*)\.md/){$1},
      {
        title: title.empty? ? "無題" : title,
      }
    ]
  end
  .to_h

dirs = [[
  path,
  {
    title: path == '' ? File.basename(Dir.pwd) : File.basename(path),
  }
]].to_h

open("tmp/#{path}/articles.json", "w"){|io|
  io.puts({files: files, dirs: dirs}.to_json)
}
