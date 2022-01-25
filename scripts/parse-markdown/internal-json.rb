
class InternalJson < Kramdown::Converter::Html
  def convert(el, indent=0, is_called_by_root = false)
    case el.type
    when :header
      level = el.options[:level]
      return [] if level == 1
      [{
        type: "header",
        level: level,
        text: el.children[0].value
      }]
    when :p
      is_codeblock = (
        el.children.length == 1 &&
        el.children[0].type == :codespan &&
        el.children[0].value.include?("\n")
      )
      if is_codeblock
        code = el.children[0].value
        lang = code.start_with?(/[a-zA-Z#+]+|.+\.[a-zA-Z]+/) ? code.lines[0].chomp : nil
        return [{
          type: "code",
          lang: lang,
          code: lang.nil? ? code.delete_prefix("\n") : code.lines[1..-1].join(""),
        }]
      end
      text = el
        .children
        .map{|c|convert(c, indent)}
        .join("")
      [{
        type: "element",
        text: "<div>#{re_parse(text)}</div>"
      }]
    when :blank
      []
    else
      if is_called_by_root
        [{
          type: "element",
          text: "<div>#{send(@dispatcher[el.type], el, indent)}</div>"
        }]
      else
        send(@dispatcher[el.type], el, indent)
      end
    end
  end
  def re_parse(text)
    text
      .split("\n")
      .reject(&:empty?)
      .chunk{|cl|cl.start_with?(/\s*-|\s*\d+\. /)}
      .map do |is_list, lines|
        if is_list
          "<div>"+Kramdown::Document.new(lines.join("\n")).to_html+"</div>"
        else
          lines.join("")
        end
      end
      .join("\n")
  end
  def convert_root(el, indent)
    el
      .children
      .flat_map{|child|convert(child, 0, true)}
  end
end
