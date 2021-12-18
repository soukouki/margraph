
files = ARGV[0..-1]

md_files, other_files = files.partition{|f|f =~ /^.*\.md$/}
md_files.each do |md|
  core = md.match(/src\/(.*)\.md$/)[1]
  dep = other_files.select{|oth|oth.match?(/src\/#{core}\..*/)}
  puts <<~EOS
    tmp/#{core}.md: #{dep.join(" ")}
  EOS
end
