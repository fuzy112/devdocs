module Docs
  class Gtk
    class EntriesFilter < Docs::EntriesFilter

      def get_name
        result[:title]
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
          when 'union'
            'Unions'
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
