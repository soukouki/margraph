
require "json"

require "kramdown"

require_relative "internal-json"

def JSON.load_file(file)
  parse(File.read(file))
end

src_path = ARGV[0]
src_dir_path = src_path.include?("/") ? File.dirname(src_path) : ""

articles = JSON.load_file("tmp/merged-articles.json")
files_articles = articles["files"]
link_network = JSON.load_file("tmp/merged-link-network.json")
attachments_files = JSON.load_file("tmp/#{src_dir_path}/attachments-files.json")

source = open("src/#{src_path}.md", "r"){|io|io.read}
title = files_articles[src_path]["title"]

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
  title: files_articles[prev_path]["title"],
}
index = {
  path: File::dirname(src_path) == "." ? "index" : File::dirname(src_path)+"/index",
  title: articles["dirs"][File::dirname(src_path) == "." ? "" : File::dirname(src_path)]["title"]
}
nxt_path = files_in_same_dir[position+1]
nxt = (position+1) == files_in_same_dir.length ? nil : {
  path: nxt_path,
  title: files_articles[nxt_path]["title"],
}

def grandchild_articles files_articles, link_network, child_path
  self_links = link_network[child_path].map do |h|
    pa = h["path"]
    {
      title: h["title"],
      path: pa,
      opening: files_articles[pa]["opening"],
      image: nil, # 画像の情報をとってくるにはまた数箇所変更する必要があるので、今回は見送る
    }
  end
  others_links = link_network
    .select{|h|h["path"] == child_path}
    .uniq
    .map do |h|
      pa = h["path"]
      {
        title: h["title"],
        path: pa,
        opening: files_articles[pa]["opening"],
        image: nil,
      }
    end
  (self_links + others_links).uniq
end

link_pathes = (
  link_network[src_path].map{|h|h["path"]} + 
  link_network
    .select{|pa, links|links.map{|h|h["path"]}.include? src_path}
    .map{|pa,_links|pa}
).uniq
linked_pathes = [src_path]
links = link_pathes
  .reject{|pa|linked_pathes.include? pa}
  .each{|pa|linked_pathes.push pa}
  .map do |child_path|
    {
      title: files_articles[child_path]["title"],
      path: child_path,
      opening: files_articles[child_path]["opening"],
      image: nil,
      links: grandchild_articles(files_articles, link_network, child_path).reject{|h|linked_pathes.include? h[:path]}.each{|h|linked_pathes.push h[:path]}
    }
  end

open("tmp/#{src_path}.inter.json", "w") do |io|
  io.puts({
    type: "article",
    title: title,
    breadcrumb: breadcrumb,
    contents: contents,
    prev: prev,
    index: index,
    next: nxt,
    links: links,
  }.to_json)
end
