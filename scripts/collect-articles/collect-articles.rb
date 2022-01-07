
require "json"

path = ARGV[0]

source_files = Dir["src/#{path}/*.md"].map{|p|p.gsub("./","")}

files = source_files
  .map do |file_path|
    title = open(file_path, 'r'){|io|io.readline}.chomp.sub(/^#\s+/, '')
    {
      title: title.empty? ? "無題" : title,
      path: file_path,
    }
  end

dir = {
  title: path == '.' ? File.basename(Dir.pwd) : path,
  path: path,
}

open("tmp/#{path}/articles.json", "w"){|io|
  io.puts({files: files, dirs: [dir]}.to_json)
}
