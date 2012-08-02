class HtmlBuilder
  def initialize
    @content = ''
  end

  def build_attributes_from(attrs)
    attrs.map { |attribute_name, attribute_value| "#{attribute_name}=\"#{attribute_value}\"" }.join(' ')
  end

  def method_missing(name, *args, &block)
    attributes = if args.last.kind_of?(Hash)
      ' ' + build_attributes_from(args.pop)
    else
      ''
    end

    content = if block_given?
      render(&block)
    else
      args.first
    end

    @content << "<#{name}#{attributes}>#{content}</#{name}>"
  end

  def render(&block)
    old_content, @content = @content, ''

    instance_eval(&block)

    result, @content = @content, old_content
    result
  end

  def self.render_file(file)
    new.instance_eval File.read(file)
  end
end

html_builder = HtmlBuilder.new
result = html_builder.render do
  html do
    head do
      title 'Hey, HTML is fun again!'
    end
    body do
      article do
        a href: 'http://google.com' do
          img src: 'https://www.google.bg/logos/2012/table_tennis-2012-hp.jpg'
        end
      end
    end
  end
end

puts "---- instance_eval(&block) ----\n\n"
puts result

puts "\n---- instance_eval('string with ruby code') ----\n\n"
puts HtmlBuilder.render_file 'template.rbhtml'
