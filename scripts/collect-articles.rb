
require "yaml"

source_dirs = ARGV[0..0]

source_files = ARGV[1..-1]

files = source_files
  .map do |file_path|
    title = open("src/#{file_path}.md", 'r'){|io|io.readline}.chomp.sub(/^#\s+/, '')
    {
      path: file_path,
      name: File.basename(file_path),
      dir: File.dirname(file_path),
      title: title.empty? ? "無題" : title,
    }
  end

dirs = source_dirs
  .map{|dir_path|
    title = File.basename(dir_path)
    {
      path: dir_path,
      dir: File.dirname(dir_path),
      title: title == '.' ? File.basename(Dir.pwd) : title,
    }
  }

{files: files, dirs: dirs}.to_yaml.display
