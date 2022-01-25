
require "json"

output = ARGV[0]
files = ARGV[1..-1]

obj = files
  .map{|path|JSON.load_file(path)}
  .inject({}) do |hash, content|
    proc = ->(key, self_val, other_val) do
      case
      when self_val.is_a?(Array) && other_val.is_a?(Array)
        self_val + other_val
      when self_val.is_a?(Hash)  && other_val.is_a?(Hash)
        self_val.merge!(other_val, &proc)
      end
    end
    hash.merge!(content, &proc)
  end

open(output, "w"){|io|
  io.puts obj.to_json
}
