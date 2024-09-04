module Docs
  class Gtk
    class EntriesFilter < Docs::EntriesFilter

      # TODO: correctly convert snake_case names
      def get_name
        type, object, member = *slug.split('.')

        case type
        when 'class'
          "Gtk#{object}"
        when 'struct'
          if object.starts_with('_')
            object.sub('_', '_Gtk')
          else
            "Gtk#{object}"
          end
        when 'type_func'
          "gtk_#{object.downcase}_#{member}"
        when 'class_method'
          "gtk_#{object.downcase}_#{member}"
        when 'ctor'
          "gtk_#{object.downcase}_#{member}"
        when 'method'
          "gtk_#{object.downcase}_#{member}"
        when 'property'
          "Gtk.#{object}:#{member}"
        when 'signal'
          "Gtk.#{object}::#{member}"
        when 'func'
          if object =~ /^[A-Z_]+$/
            "GTK_#{object}"
          else
            "gtk_#{object}"
          end
        when 'vfunc'
          "Gtk.#{object}.#{member}"
        when 'enum'
          "Gtk#{object}"
        when 'flags'
          "Gtk#{object}"
        when 'const'
          "GTK_#{object.upcase}"
        when 'iface'
          "Gtk#{object}"
        when 'alias'
          "Gtk#{object}"
        when 'callback'
          "Gtk#{object}"
        when 'error'
          "Gtk.#{object}"
        else
          node = at_css('h4')
          node.css('.srclink').remove
          node.content
        end
      end

      def get_type
        slug_components = slug.split('.')
        if slug_components.length == 1
          'Additional documentation'
        else
          case slug_components[0]
          when 'class'
            'Classes'
          when 'struct'
            'Structs'
          when 'type_func'
            'Functions'
          when 'ctor'
            'Constructors'
          when 'method'
            'Methods'
          when 'class_method'
            'Class Methods'
          when 'property'
            'Properties'
          when 'signal'
            'Signals'
          when 'func'
            if slug_components[1] =~ /^[A-Z_]+$/
              'Function Macros'
            else
              'Functions'
            end
          when 'vfunc'
            'Virtual Methods'
          when 'enum'
            'Enumerations'
          when 'flags'
            'Bitfields'
          when 'error'
            'Error Domains'
          when 'const'
            'Constants'
          when 'iface'
            'Interfaces'
          when 'alias'
            'Aliases'
          when 'callback'
            'Callbacks'
          else
            raise "Unknown type #{slug}"
          end
        end
      end

      def additional_entries
        entries = []

        if slug =~ /error|flags|enum/
          css("dl.enum-members > dt > code").each do |node|
            entries << [node.content, node['id']]
          end
        end

        if slug =~ /struct/
          css("dl > dt > code").each do |node|
            entries << [name + "." + node.content, node['id']]
          end
        end

        entries
      end

    end
  end
end
