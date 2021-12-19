
require './scripts/utility'

def make_breadcrumb_for_dir index, dir
  return '' if dir == '.'
  make_breadcrumb(index, dir+'/')
end
def make_breadcrumb_for_file index, file
  make_breadcrumb(index, file)
end

def make_breadcrumb index, dir_or_file
  root_dir_path = root_dir_path(dir_or_file)
  head = [
    %!<li class="breadcrumb-item"><a href="#{root_dir_path}index.html">#{index[:dirs].find{|h|h[:path] == "."}[:title]}</a></li>!
  ]
  breadcrumb_path = ''
  middle = dir_or_file.split('/')[0..-2].map{|dir|
    breadcrumb_path += dir
    title = index[:dirs].find{|h|h[:path]==breadcrumb_path}[:title]
    breadcrumb_path += '/'
    %!<li class="breadcrumb-item"><a href="#{root_dir_path}#{breadcrumb_path}index.html">#{title}</a></li>!
  }
  tail_title = (
    index[:files].find{|h|h[:path] == dir_or_file}&.[](:title) ||
      File.basename(dir_or_file)
  )
  tail = [
    %!<li class="breadcrumb-item active" aria-current="page">#{tail_title}</li>!
  ]
  list = head + middle + tail
  (<<~HTML
    <nav style="--bs-breadcrumb-divider: '>';" aria-lavel="breadcrumb">
      <ol class="breadcrumb">
        #{list.join("\n")}
      </ol>
    </nav>
  HTML
  )+"\n"
end
