
require "json"

MAX_NUM_OF_OPENING_CHARS = 30

path = ARGV[0]

source_files = Dir["src/#{path}/*.md"].map{|p|p.gsub("//","/")}

files = source_files
  .map do |file_path|
    text = open(file_path, 'r'){|io|io.read}
    title = text.each_line.first.chomp.sub(/^#\s+/, '')
    title = "無題" if title.empty?
    num_of_opening_chars = 0
    opening = text
      .each_line
      .lazy
      .drop(1)
      .map{|line|line.sub(/=+/, '').sub(/$\s+/, '').chomp}
      .reject(&:empty?)
      .take_while{|line|state = num_of_opening_chars < MAX_NUM_OF_OPENING_CHARS; num_of_opening_chars += line.length; state}
      .to_a
      .join(" ")[0..MAX_NUM_OF_OPENING_CHARS]
      [
        file_path.gsub(/src\/(.*)\.md/){$1},
        {
          title: title,
          opening: opening
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
