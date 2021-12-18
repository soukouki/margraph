
require 'yaml'

require './scripts/utility'
require './scripts/breadcrumb'

target_file = ARGV[0]

mixin_files = ARGV[1..-1]

index = YAML.load_file('tmp/merged_article_list.yaml')

network = YAML.load_file('tmp/merged_network.yaml')

root_dir_path = root_dir_path(target_file)

source = make_breadcrumb_for_file(index, target_file)

article = open("src/#{target_file}.md", 'r'){|io|io.read}

replace_index = article.each_line.first.length
network[target_file].each do |link|
  replace_by = link[:text]
  found_index = article.index(replace_by, replace_index)
  break if found_index.nil?
  replace_to = "[#{replace_by}](#{root_dir_path}#{link[:path]}.html)"
  article[found_index...found_index+replace_by.length] = replace_to
  replace_index = found_index + replace_to.length
end

source += article

files_in_same_dir = index[:files]
  .select{|h|h[:dir] == File.dirname(target_file)}
  .sort_by{|h|h[:path]}

index_in_same_dir = files_in_same_dir.find_index{|p|p[:path] == "#{target_file}"}

index_title = index[:dirs].find{|h|h[:path] == File.dirname(target_file)}[:title]

mixin_files.each do |file|
  source += (
    "<pre><code class=\"language-#{File.extname(file)[1..-1]}\">"+
    open(file){|f|f.read}.gsub(/\A\n+/,"")+
    "</code></pre>"
  )
end

source += <<~MD


  <button type="button" class="btn-primary" onclick="window.location.href='#{ENV['EDITLINK']}src/#{target_file}.md';">Edit</button>
  
  ---
  <div class="row text-center">
  <div class="col">
  #{
    if index_in_same_dir != 0
      pre = files_in_same_dir[index_in_same_dir-1]
      "前のページ<br><a href=\"#{pre[:name]}.html\">#{pre[:title]}</a>\n"
    end
  }
  </div>
  <div class="col">
    目次<br><a href="index.html">#{index_title}</a>
  </div>
  <div class="col">
  #{
    if index_in_same_dir != files_in_same_dir.length-1
      nex = files_in_same_dir[index_in_same_dir+1]
      "後のページ<br><a href=\"#{nex[:name]}.html\">#{nex[:title]}</a>\n"
    end
  }
  </div>
  </div>
MD

puts source