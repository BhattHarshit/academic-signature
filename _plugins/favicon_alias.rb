# frozen_string_literal: true

require 'fileutils'

# Keep the favicon source set together while still serving /favicon.ico for
# browsers that request the conventional root path automatically.
Jekyll::Hooks.register :site, :post_write do |site|
  source = File.join(site.source, 'assets', 'img', 'favicons', 'favicon.ico')
  next unless File.file?(source)

  FileUtils.cp(source, File.join(site.dest, 'favicon.ico'))
end
