module Docs
  class Gdk < Docs::Gtk
    self.name = 'GDK'
    self.slug = 'gdk'
    self.type = 'gdk'

    version '3.0' do
      self.base_url = 'https://docs.gtk.org/gdk3/'
      options[:root_title] = 'GDK 3 API Reference'
    end

    version '4.0' do
      self.base_url = 'https://docs.gtk.org/gdk4/'
      options[:root_title] = 'GDK 4 API Reference'
    end
  end
end
