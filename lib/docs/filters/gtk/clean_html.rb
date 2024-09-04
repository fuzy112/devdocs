module Docs
  class Gtk
    class CleanHtmlFilter < Filter
      def call

        css('header').remove
        css('.srclink').remove
        css('h4#title').remove
        css('.hierarchy').remove

        # Fix code highlighting
        css('pre').each do |node|
          # If a codeblock has URLs, don't touch it
          next if node.at_css('a[href]')

          node.content = node.content

          # it's not perfect, but make a guess at language
          if node.content.starts_with?('<')
            node['data-language'] = 'xml'
          elsif node.content =~ /(final |abstract )?class|interface/
            node['data-language'] = 'vala'
          else
            node['data-language'] = 'c'
          end
        end

        doc
      end
    end
  end
end
