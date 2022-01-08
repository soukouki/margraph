
require 'json'

index = JSON.load_file('tmp/merged-articles.json')

files_map = index['files'].map{|arr|[arr['path'], arr['title']]}.to_h

network = JSON.load_file('tmp/merged-link-network.json')

body = network
  .flat_map do |pre_name, pre_arr|
    pre_arr.map{|nex_item|"\"#{files_map[pre_name]}\" -> \"#{files_map[nex_item['path']]}\""}
  end
  .join("\n")

puts <<~DOT
  digraph {
    layout = fdp;
    #{body}
  }
DOT
