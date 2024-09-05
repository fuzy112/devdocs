module Docs
  class Glib < Docs::Gtk
    self.name = 'GLib'
    self.slug = 'glib'
    self.type = 'glib'

    self.links = {
      home: 'https://www.gtk.org',
      code: 'https://gitlab.gnome.org/GNOME/glib'
    }

    self.release = '2.83.0'
    self.base_url = 'https://docs.gtk.org/glib/'

    options[:attribution] = <<-HTML
      &copy; 1997&ndash;2024 GLib Development Team
      Licensed under the GNU Lesser General Public License version 2.1 or later.
    HTML

    options[:func_prefix] = 'g_'
    options[:type_prefix] = 'G'
    options[:macro_prefix] = 'G_'

    options[:root_title] = 'GLib API Reference'

    def get_latest_version(opts)
      tags = get_gitlab_tags('gitlab.gnome.org', 'GNOME', 'glib', opts)
      tags[0]['name']
    end
  end
end
