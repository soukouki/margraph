
require "json"

def JSON.load_file(file)
  parse(File.read(file))
end

articles = JSON.load_file("tmp/merged-articles.json")

target_path = ARGV[0]

target_path_to_search_dir = target_path == "" ? "." : target_path
dirs = articles["dirs"]
  .reject{|path|path == ""}
  .select{|path|File.dirname(path) == target_path_to_search_dir}
  .keys
  .sort
target_path_to_search_file = target_path == "" ? "/" : target_path
files = articles["files"]
  .select{|path|File.dirname(path) == target_path_to_search_dir}
  .keys
  .sort

breadcrumb = target_path
  .split("/")
  .inject([""]){|r,i|r + [r[-1] == "" ? i : r[-1]+"/"+i]}
  .map do |dir_path|
    {
      path: dir_path == "" ? "index" : dir_path+"/index",
      title: articles["dirs"][dir_path]["title"]
    }
  end

open("tmp/#{target_path}/index.inter.json", "w") do |io|
  io.puts({
    type: "index",
    title: articles["dirs"][target_path]["title"],
    breadcrumb: breadcrumb,
    dirs: dirs.map{|path|{path: path, title: articles["dirs"][path]["title"]}},
    files: files.map{|path|{path: path, title: articles["files"][path]["title"]}},
  }.to_json)
end
