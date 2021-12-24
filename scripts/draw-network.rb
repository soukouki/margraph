
require 'yaml'

index = YAML.load_file('tmp/merged_article_list.yaml')

files_map = index[:files].map{|arr|[arr[:path], arr[:title]]}.to_h

network = YAML.load_file('tmp/merged_network.yaml')

body = network
  .flat_map do |pre_name, pre_arr|
    pre_arr.map{|nex_item|"\"#{files_map[pre_name]}\" -> \"#{files_map[nex_item[:path]]}\""}
  end
  .join("\n")

puts <<~DOT
  digraph {
    layout = fdp;
    #{body}
  }
DOT
