module Docs
  class Gtk < UrlScraper
    self.name = 'GTK'
    self.slug = 'gtk'
    self.type = 'gtk'
    self.root_path = 'index.html'
    self.links = {
      home: 'https://www.gtk.org/',
      code: 'https://gitlab.gnome.org/GNOME/gtk/'
    }

    html_filters.insert 0, 'gtk/title'
    html_filters.push 'gtk/entries', 'gtk/clean_html', 'title'

    options[:container] = '.content'

    options[:skip] = %w(
       class_hierarchy.html
    )

    options[:attribution] = <<-HTML
      &copy; 2005&ndash;2020 The GNOME Project<br>
      Licensed under the GNU Lesser General Public License version 2.1 or later.
    HTML

    version '3.0' do
      self.release = '3.24'
      self.base_url = 'https://docs.gtk.org/gtk3/'

      options[:root_title] = 'GTK+3 Reference Manual'
    end

    version '4.0' do
      self.release = '4.15.7'
      self.base_url = 'https://docs.gtk.org/gtk4/'

      options[:root_title] = 'GTK 4 Reference Manual'
    end

    def get_latest_version(opts)
      tags = get_gitlab_tags('gitlab.gnome.org', 'GNOME', 'gtk', opts)
      tags[0]['name']
    end
  end
end
