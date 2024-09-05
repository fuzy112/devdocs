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

    # These are all "index"-ish pages with no valuable content
    GTK3_SKIP = %w(

    )

    GTK3_SKIP_PATTERNS = [

    ]

    # These are all "index"-ish pages with no valuable content
    GTK4_SKIP = %w(

    )

    GTK4_SKIP_PATTERNS = [

    ]

    options[:attribution] = <<-HTML
      &copy; 2005&ndash;2020 The GNOME Project<br>
      Licensed under the GNU Lesser General Public License version 2.1 or later.
    HTML

    version '3.0' do
      self.release = '3.24'
      self.base_url = 'https://docs.gtk.org/gtk3/'

      options[:root_title] = 'GTK+3 Reference Manual'
      options[:skip] = GTK3_SKIP
      options[:skip_patterns] = GTK3_SKIP_PATTERNS
    end

    version '4.0' do
      self.release = '4.15.7'
      self.base_url = 'https://docs.gtk.org/gtk4/'

      options[:root_title] = 'GTK 4 Reference Manual'
      options[:skip] = GTK4_SKIP
      options[:skip_patterns] = GTK4_SKIP_PATTERNS
    end

    def get_latest_version(opts)
      tags = get_gitlab_tags('gitlab.gnome.org', 'GNOME', 'gtk', opts)
      tags[0]['name']
    end
  end
end
