module Docs
  class Gtk
    class TitleFilter < Docs::Filter
      def call
        result[:title] = doc.at_css('title').content.strip
        doc
      end
    end
  end
end
