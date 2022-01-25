
require "json"
require "erb"

def JSON.load_file(file, **opt)
  parse(File.read(file), opt)
end

path = ARGV[0]

inter_rep = JSON.load_file("tmp/#{path}.inter.json", symbolize_names: true)

root_dir_path = "../"*path.count("/")

type = inter_rep[:type]
title = inter_rep[:title]
breadcrumb = inter_rep[:breadcrumb]
contents = inter_rep[:contents]

prev_index_next = [inter_rep[:prev], inter_rep[:index], inter_rep[:next]]
prev_index_next = nil if prev_index_next.all?(&:nil?)

dirs = inter_rep[:dirs]
files = inter_rep[:files]

open("public/#{path}.html", "w") do |io|
  io.puts ERB.new(open("scripts/make-html/base.erb", "r").read).result(binding)
end
