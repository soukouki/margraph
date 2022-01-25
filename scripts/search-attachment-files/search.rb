
require "json"

src_path = ARGV[0]

files = if src_path == ""
  Dir.glob("src/*.*")
else
  Dir.glob("src/#{src_path}/*.*")
end

p files