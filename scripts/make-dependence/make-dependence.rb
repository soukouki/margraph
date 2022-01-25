
require "json"

src_path = ARGV[0]

attachments = JSON.load_file("tmp/#{src_path}/attachments-files.json")

result = attachments
  .map do |path, attas|
    attas
      .map do |atta|
        case atta["type"]
        when "image"
          atta_file = "#{atta["path"]}.#{atta["extension"]}"
          <<~MAKEFILE
            public/#{path}.html: public/#{atta_file}
            public/#{atta_file}: src/#{atta_file}
            \t$(MKDIR)
            \tcp src/#{atta_file} public/#{atta_file}
            tmp/#{path}.inter.json: src/#{atta_file}
          MAKEFILE
        when "text"
          <<~MAKEFILE
            tmp/#{path}.inter.json: src/#{atta_file}
          MAKEFILE
        end
      end
      .join("")
  end
  .join("")

open("tmp/#{src_path}/dependence.dep", "w") do |io|
  io.puts result
end
