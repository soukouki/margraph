
require 'yaml'

files = Dir['src/**/*.md']
  .map{|fp|fp.sub(/^src\//, '').sub(/.md$/, '')}
  .map{|file_path|
    title = open("src/#{file_path}.md", 'r'){|io|io.readline}.chomp.sub(/^#\s+/, '')
    {
      path: file_path,
      name: File.basename(file_path),
      dir: File.dirname(file_path),
      title: title.empty? ? "無題" : title,
    }
  }
dirs = files
  .map{|hash|hash[:dir]}
  .uniq
  .map{|dir_path|
    title = File.basename(dir_path)
    {
      path: dir_path,
      dir: File.dirname(dir_path),
      title: title == '.' ? File.basename(Dir.pwd) : title,
    }
  }

open('tmp/index.yaml', 'w'){|io|
  YAML.dump({files: files, dirs: dirs}, io)
}
