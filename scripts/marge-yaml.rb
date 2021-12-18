
require "yaml"

files = ARGV

files
  .map{|path|YAML.load_file(path)}
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
  .to_yaml
  .display
