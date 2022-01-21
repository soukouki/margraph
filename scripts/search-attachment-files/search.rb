
require "json"

src_path = ARGV[0]

files = Dir.grep("src/#{src_path}/*.*")

p files