
require "json"

require "kramdown"

require_relative "internal-json"

def JSON.load_file(file)
  parse(File.read(file))
end

src_path = ARGV[0]
src_dir_path = src_path.include?("/") ? File.dirname(src_path) : ""

articles = JSON.load_file("tmp/merged-articles.json")
link_network = JSON.load_file("tmp/merged-link-network.json")
attachments_files = JSON.load_file("tmp/#{src_dir_path}/attachments-files.json")

source = open("src/#{src_path}.md", "r"){|io|io.read}

replace_index = source.each_line.first.length
link_network[src_path].each do |link|
  replace_by = link["title"]
  found_index = source.index(replace_by, replace_index)
  break if found_index.nil?
  replace_to = "[#{replace_by}](#{"../"*src_path.count("/")}#{link["path"]}.html)"
  source[found_index...found_index+replace_by.length] = replace_to
  replace_index = found_index + replace_to.length
end

def make_breadcrumb articles, path
  (path
    .split("/")[0..-2]
    .inject([""]){|arr,item|arr + [arr[-1] == "" ? item : arr[-1]+"/"+item]}
    .map do |path|
      {
        path: path=="" ? "index" : path+"/index",
        title: articles["dirs"][path]["title"],
      }
    end
  )+ [{path: path, title: articles["files"][path]["title"]}]
end

def files_in_same_dir articles, path
  dir = File.dirname(path)
  articles["files"]
    .select{|file_path|File.dirname(file_path) == dir}
    .keys
    .sort
end

breadcrumb = make_breadcrumb(articles, src_path)

attachments = attachments_files[src_path].map do |atta|
  case atta["type"]
  when "image"
    {
      type: "image",
      path: atta["path"],
      extension: atta["extension"]
    }
  when "text"
    {
      type: "code",
      lang: atta["extension"],
      code: open("src/#{atta["path"]}.#{atta["extension"]}"){|io|io.read}
    }
  end
end
root = Kramdown::Document.new(source).root
contents = InternalJson.convert(root)[0] + attachments

files_in_same_dir = files_in_same_dir(articles, src_path)
position = files_in_same_dir.index(src_path)

prev_path = files_in_same_dir[position-1]
prev = position == 0 ? nil : {
  path: prev_path,
  title: articles["files"][prev_path]["title"],
}
index = {
  path: File::dirname(src_path) == "." ? "index" : File::dirname(src_path)+"/index",
  title: articles["dirs"][File::dirname(src_path) == "." ? "" : File::dirname(src_path)]["title"]
}
nxt_path = files_in_same_dir[position+1]
nxt = (position+1) == files_in_same_dir.length ? nil : {
  path: nxt_path,
  title: articles["files"][nxt_path]["title"],
}

open("tmp/#{src_path}.inter.json", "w") do |io|
  io.puts({
    type: "article",
    title: articles["files"][src_path]["title"],
    breadcrumb: breadcrumb,
    contents: contents,
    prev: prev,
    index: index,
    next: nxt,
  }.to_json)
end
