
require 'yaml'

require './scripts/breadcrumb'

target_dir = ARGV[0]

index = YAML.load_file('tmp/index.yaml')

files = index[:files]
  .filter{|hash|hash[:dir] == target_dir}
  .sort_by{|hash|hash[:path]}

dirs = index[:dirs]
  .filter{|hash|hash[:dir] == target_dir}
  .sort_by{|hash|hash[:path]}
  .delete_if{|hash|hash[:path] == target_dir}

puts make_breadcrumb_for_dir(index, target_dir)

puts <<~MD
  #{index[:dirs].find{|h|h[:path] == target_dir}[:title]} の目次
  =====

  <div class="d-grid gap-3">
  <div></div>
  #{
    unless dirs.empty?
      <<~DIRS
        <div class="card">
        <h2 class="card-header">
          フォルダ
        </h2>
        <ul class="list-group list-group-flush">
        #{
          dirs.map{|h|
            %!<li class="list-group-item"><a href="#{h[:path]}/index.html">#{h[:title]}</a></li>!
          }.join("\n")
        }
        </ul>
        </div>
      DIRS
    end
  }
  
  #{
    unless files.empty?
      <<~FILES
        <div class="card">
        <h2 class="card-header">
          メモ
        </h2>
        <ul class="list-group list-group-flush">
        #{
          files.map{|h|
            %!<li class="list-group-item"><a href="#{h[:name]}.html">#{h[:title]}</a></li>!
          }.join("\n")
        }
        </ul>
        </div>
      FILES
    end
  }

  <button type="button" class="btn-primary" onclick="window.location.href='#{ENV['NEWFILELINK']}src/#{target_dir}';">Add</button>

  </div>
MD
