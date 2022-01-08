
require "json"

require "kramdown"

src_path = ARGV[0]

articles = JSON.load_file("tmp/merged-articles.json")
link_network = JSON.load_file("tmp/merged-link-network.json")

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

root = Kramdown::Document.new(source).root

class InternalJson < Kramdown::Converter::Html
  def convert(el, indent=0, is_called_by_root = false)
    case el.type
    when :header
      level = el.options[:level]
      return [] if level == 1
      [{
        type: "header",
        level: level,
        text: el.children[0].value
      }]
    when :p
      if el.children.length == 1 && el.children[0].type == :codespan
        code = el.children[0].value
        lang = code.start_with?(/[a-zA-Z#+]+|.+\.[a-zA-Z]+/) ? code.lines[0] : nil
        return [{
          type: "code",
          lang: lang,
          code: code,
        }]
      end
      text = el.children.map do |c|
        if c.type != :text
          convert(c, indent)
        else
          convert_text_with_list(c)
        end
      end
      .join("<br>")
      [{
        type: "element",
        text: "<div>#{text}</div>"
      }]
    when :blank
      []
    else
      if is_called_by_root
        [{
          type: "element",
          text: "<div>#{send(@dispatcher[el.type], el, indent)}</div>"
        }]
      else
        send(@dispatcher[el.type], el, indent)
      end
    end
  end
  def convert_text_with_list(el)
    el
      .value
      .split("\n")
      .reject(&:empty?)
      .chunk{|cl|cl.start_with?(/\s*-|\s*\d+\. /)}
      .map do |is_list, lines|
        if is_list
          "<div>"+Kramdown::Document.new(lines.join("\n")).to_html+"</div>"
        else
          lines.join("<br>")
        end
      end
      .join("\n")
  end
  def convert_root(el, indent)
    el
      .children
      .flat_map{|child|convert(child, 0, true)}
  end
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
contents = InternalJson.convert(root)[0]
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
