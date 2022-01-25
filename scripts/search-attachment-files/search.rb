
require "json"

src_path = ARGV[0]

def binaryfile? origin
  open(origin, "r"){|io|io.read(8000).each_byte.any?{|c|c==0}}
end

file_origins = if src_path == ""
  Dir.glob("src/*.*")
else
  Dir.glob("src/#{src_path}/*.*")
end

files = file_origins.map do |origin|
  path, ext = origin.match(/^src\/(.+?)(?:\.([^.]+))$/).to_a.values_at(1,2)
  {
    origin: origin,
    path: path,
    ext: ext,
  }
end

md_files, other_files = files.partition{|f|f[:ext] == "md"}

result = md_files
  .map do |md_file|
    atta = other_files
      .select{|other|other[:path].start_with? md_file[:path]}
      .reject{|atta|binaryfile?(atta[:origin])}
      .map do |atta|
        {
          path: atta[:path],
          extension: atta[:ext],
          type: ["png", "json", "gif", "svg"].include?(atta[:ext]),
        }
      end
    [md_file[:path], atta]
  end
  .to_h

open("tmp/#{src_path}/attachments-files.json", "w") do |io|
  io.puts result.to_json
end
