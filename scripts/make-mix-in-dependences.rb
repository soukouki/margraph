
target = ARGV[0]

mdfile = "src/#{target}.md"

dep = (Dir["src/#{target}.*"] - [mdfile]).join(" ")

puts <<~EOS
  tmp/#{target}.md: #{dep}
EOS
