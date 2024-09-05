module Docs
  class Gtk
    class EntriesFilter < Docs::EntriesFilter

      def get_name

        macro_prefix = context[:macro_prefix]
        func_prefix = context[:func_prefix]
        type_prefix = context[:type_prefix]

        type, object, member = *slug.split('.')

        case type
        when 'class'
          "#{type_prefix}#{object}"
        when 'struct'
          if object.starts_with?('_')
            object.sub('_', "_#{type_prefix}")
          else
            "#{type_prefix}#{object}"
          end
        when 'union'
          "#{type_prefix}#{object}"
        when 'type_func'
          "#{func_prefix}#{snake_case(object)}_#{member}"
        when 'class_method'
          "#{func_prefix}#{snake_case(object)}_#{member}"
        when 'ctor'
          "#{func_prefix}#{snake_case(object)}_#{member}"
        when 'method'
          "#{func_prefix}#{snake_case(object)}_#{member}"
        when 'property'
          "#{type_prefix}.#{object}:#{member}"
        when 'signal'
          "#{type_prefix}.#{object}::#{member}"
        when 'func'
          if object =~ /^[A-Z_]+$/
            "#{macro_prefix}#{object}"
          else
            "#{func_prefix}#{object}"
          end
        when 'vfunc'
          "#{type_prefix}.#{object}.#{member}"
        when 'enum'
          "#{type_prefix}#{object}"
        when 'flags'
          "#{type_prefix}#{object}"
        when 'const'
          "#{macro_prefix}#{object.upcase}"
        when 'iface'
          "#{type_prefix}#{object}"
        when 'alias'
          "#{type_prefix}#{object}"
        when 'callback'
          "#{type_prefix}#{object}"
        when 'error'
          "#{type_prefix}.#{object}"
        else
          node = at_css('h4')
          node.css('.srclink').remove
          node.content
        end
      end

      def snake_case(str)
        return str.downcase if str =~ /^[A-Z_]+$/
        str.gsub(/\B[A-Z]/, '_\&').squeeze("_") =~ /_*(.*)/
        $+.downcase
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
