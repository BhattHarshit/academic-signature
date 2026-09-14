#!/usr/bin/env ruby
# frozen_string_literal: true

require 'date'
require 'json'
require 'yaml'

ROOT = File.expand_path('../..', __dir__)
errors = []

def read_yaml(path)
  YAML.safe_load(File.read(path, encoding: 'UTF-8'), permitted_classes: [Date, Time], aliases: true) || {}
end

def require_file(errors, relative)
  errors << "Missing required file: #{relative}" unless File.file?(File.join(ROOT, relative))
end

def asset_path(value)
  text = value.to_s.strip
  return nil if text.empty?
  return text.delete_prefix('/') if text.start_with?('/')

  File.join('assets', 'img', text)
end

profile_path = File.join(ROOT, '_data', 'profile.yml')
config_path = File.join(ROOT, '_config.yml')

require_file(errors, '_data/profile.yml')
require_file(errors, '_config.yml')

if File.file?(profile_path)
  profile = read_yaml(profile_path)

  %w[identity site profile cv scholar socials repositories blog comments].each do |key|
    errors << "_data/profile.yml is missing '#{key}'." unless profile.key?(key)
  end

  %w[search footer].each do |key|
    errors << "Move '#{key}' out of _data/profile.yml; it is an internal site setting." if profile.key?(key)
  end

  site_settings = profile.fetch('site', {})
  %w[icon apple_touch_icon og_image academic_signature_url].each do |key|
    errors << "Move site.#{key} out of _data/profile.yml; it is an internal site setting." if site_settings.key?(key)
  end

  cv = profile.fetch('cv', {})
  errors << 'cv.website_view must be true or false.' unless [true, false].include?(cv['website_view'])

  pdf = cv['pdf'].to_s.strip
  require_file(errors, pdf.delete_prefix('/')) if pdf.start_with?('/')
end

config = {}
if File.file?(config_path)
  config = read_yaml(config_path)
  config_text = File.read(config_path, encoding: 'UTF-8')

  errors << "Remove obsolete Jekyll Scholar option 'repository: false'." if config_text.match?(/^\s*repository:\s*false\s*$/)
  errors << "Remove obsolete Jekyll Scholar option 'use_raw_bibtex_entry'." if config_text.include?('use_raw_bibtex_entry:')
  errors << 'The upstream search layer should remain disabled; Academic Signature provides full-site search.' if config_text.match?(/^search_enabled:\s*true\s*$/)

  errors << '_config.yml is missing academic_signature_url.' if config['academic_signature_url'].to_s.strip.empty?
  errors << '_config.yml is missing signature_search settings.' unless config['signature_search'].is_a?(Hash)
  errors << '_config.yml is missing signature_footer settings.' unless config['signature_footer'].is_a?(Hash)

  [config['icon'], config['apple_touch_icon']].each do |value|
    relative = asset_path(value)
    require_file(errors, relative) if relative
  end
end

%w[
  _includes/signature_search.liquid
  _layouts/cv.liquid
  _plugins/favicon_alias.rb
  _plugins/local_dev_webrick.rb
  _plugins/profile_bridge.rb
  _plugins/signature_search.rb
  _sass/_themes.scss
  assets/js/signature-search.js
  assets/img/favicons/favicon.ico
  assets/img/favicons/favicon-16x16.png
  assets/img/favicons/favicon-32x32.png
  assets/img/favicons/apple-touch-icon.png
  assets/img/favicons/android-chrome-192x192.png
  assets/img/favicons/android-chrome-512x512.png
  assets/img/favicons/site.webmanifest
  bin/check
  bin/serve
  bin/setup
  _academic_signature/README.md
  _academic_signature/requirements.txt
  _academic_signature/purgecss.config.js
].each { |relative| require_file(errors, relative) }

manifest_path = File.join(ROOT, 'assets', 'img', 'favicons', 'site.webmanifest')
if File.file?(manifest_path)
  begin
    JSON.parse(File.read(manifest_path, encoding: 'UTF-8'))
  rescue JSON::ParserError => e
    errors << "site.webmanifest is invalid JSON: #{e.message}"
  end
end

cv_layout = File.join(ROOT, '_layouts', 'cv.liquid')
if File.file?(cv_layout)
  text = File.read(cv_layout, encoding: 'UTF-8')
  unless text.match?(/\{% if website_view %\}.*Open PDF.*\{% endif %\}/m)
    errors << 'Open PDF must only appear in website CV mode.'
  end
end

nav_orders = Hash.new { |hash, key| hash[key] = [] }
Dir.glob(File.join(ROOT, '_pages', '*.{md,markdown,html,liquid}')).sort.each do |path|
  text = File.read(path, encoding: 'UTF-8')
  next unless text.start_with?("---\n")

  front_matter = text.split(/^---\s*$\n?/, 3)[1]
  next unless front_matter

  data = YAML.safe_load(front_matter, aliases: true) || {}
  next unless data['nav'] == true
  next if data['nav_order'].nil?

  nav_orders[data['nav_order']] << File.basename(path)
end

nav_orders.each do |order, files|
  errors << "Duplicate nav_order #{order}: #{files.join(', ')}" if files.length > 1
end

if errors.empty?
  puts 'Academic Signature checks: OK'
  exit 0
end

warn "Academic Signature checks: #{errors.length} error(s)"
errors.each { |message| warn "  - #{message}" }
exit 1
