# frozen_string_literal: true

require 'json'
require 'cgi'
require 'time'

module AcademicSignature
  class SearchIndexPage < Jekyll::PageWithoutAFile
    def initialize(site, records)
      super(site, site.source, 'assets', 'search-index.json')
      @content = JSON.generate(records)
      @data = {
        'layout' => nil,
        'sitemap' => false,
        'permalink' => '/assets/search-index.json'
      }
    end
  end

  class SearchIndexGenerator < Jekyll::Generator
    safe true
    priority :lowest

    COLLECTION_LABELS = {
      'posts' => 'Notes',
      'projects' => 'Projects',
      'teachings' => 'Teaching',
      'news' => 'News'
    }.freeze

    def generate(site)
      profile_search = site.data.fetch('profile', {}).fetch('search', {})
      return if profile_search['enabled'] == false

      records = []
      seen_urls = {}

      site.pages.each do |page|
        next unless page.path.to_s.start_with?('_pages/')
        next if page.data['search'] == false
        next if page.data['permalink'] == '/404.html'
        next if page.data['permalink'] == '/sitemap/'

        add_record(records, seen_urls, site, page, 'Page')
      end

      COLLECTION_LABELS.each do |collection_name, label|
        collection = site.collections[collection_name]
        next unless collection

        collection.docs.each do |doc|
          next if doc.data['search'] == false
          add_record(records, seen_urls, site, doc, label)
        end
      end

      records.concat(publication_records(site))
      site.pages << SearchIndexPage.new(site, records)
    end

    private

    def add_record(records, seen_urls, site, document, type)
      url = document.url.to_s
      url = '/news/' if type == 'News' && document.data['inline'] == true
      return if url.empty? || seen_urls[url]

      title = document.data['title'].to_s.strip
      title = infer_title(document) if title.empty?
      return if title.empty?

      description = document.data['description'].to_s
      content = plain_text(site, document.content.to_s)
      text = [description, content].reject(&:empty?).join(' ').strip
      records << {
        id: "#{type.downcase.gsub(/\W+/, '-')}:#{url}",
        title: title,
        url: relative_url(site, url),
        type: type,
        description: compact_text(description),
        text: compact_text(text),
        date: searchable_date(document),
        keywords: Array(document.data['tags']) + Array(document.data['categories'])
      }
      seen_urls[url] = true
    end

    def infer_title(document)
      case document.collection&.label
      when 'news'
        'News update'
      else
        File.basename(document.path.to_s, File.extname(document.path.to_s)).tr('-_', ' ').split.map(&:capitalize).join(' ')
      end
    end

    def plain_text(site, raw)
      source = raw
        .gsub(/\{%.*?%\}/m, ' ')
        .gsub(/\{\{.*?\}\}/m, ' ')

      html = begin
        converter = site.find_converter_instance(Jekyll::Converters::Markdown)
        converter.convert(source)
      rescue StandardError
        source
      end

      compact_text(CGI.unescapeHTML(html.gsub(/<script\b[^>]*>.*?<\/script>/mi, ' ')
        .gsub(/<style\b[^>]*>.*?<\/style>/mi, ' ')
        .gsub(/<[^>]+>/, ' ')))
    end

    def compact_text(value)
      value.to_s.gsub(/\s+/, ' ').strip
    end

    def searchable_date(document)
      value = document.data['date']
      value.respond_to?(:iso8601) ? value.iso8601 : value.to_s
    end

    def relative_url(site, url)
      baseurl = site.config['baseurl'].to_s
      return url if baseurl.empty? || url.start_with?(baseurl)

      "#{baseurl}#{url}"
    end

    def publication_records(site)
      source = site.config.dig('scholar', 'source').to_s.sub(%r{^/}, '')
      bibliography = site.config.dig('scholar', 'bibliography').to_s
      path = File.join(site.source, source, bibliography)
      return [] unless File.file?(path)

      parse_bibtex(File.read(path, encoding: 'UTF-8')).map do |entry|
        fields = entry[:fields]
        title = clean_bib_value(fields['title'])
        next if title.empty?

        author = clean_bib_value(fields['author'])
        venue = clean_bib_value(fields['journal'] || fields['booktitle'])
        year = clean_bib_value(fields['year'])
        abstract = clean_bib_value(fields['abstract'])
        text = compact_text([author, venue, year, abstract].reject(&:empty?).join(' '))

        {
          id: "publication:#{entry[:key]}",
          title: title,
          url: relative_url(site, '/publications/'),
          type: 'Publications',
          description: compact_text([author, venue, year].reject(&:empty?).join(' · ')),
          text: text,
          date: year,
          keywords: %w[paper publication bibliography]
        }
      end.compact
    rescue StandardError => e
      Jekyll.logger.warn 'Academic Signature search:', "bibliography indexing skipped (#{e.message})"
      []
    end

    # Small dependency-free BibTeX reader for search metadata. Jekyll Scholar
    # remains responsible for authoritative publication rendering.
    def parse_bibtex(text)
      entries = []
      cursor = 0
      while (match = text.match(/@(\w+)\s*\{\s*([^,]+),/m, cursor))
        depth = 1
        i = match.end(0)
        quote = false
        escape = false
        while i < text.length && depth.positive?
          ch = text[i]
          if escape
            escape = false
          elsif ch == '\\'
            escape = true
          elsif ch == '"'
            quote = !quote
          elsif !quote
            depth += 1 if ch == '{'
            depth -= 1 if ch == '}'
          end
          i += 1
        end
        body = text[match.end(0)...(i - 1)] || ''
        entries << { key: match[2].strip, fields: parse_bib_fields(body) }
        cursor = i
      end
      entries
    end

    def parse_bib_fields(body)
      fields = {}
      body.scan(/(\w+)\s*=\s*(\{(?:[^{}]|\{[^{}]*\})*\}|"(?:\\.|[^"])*"|[^,]+)\s*,?/m) do |name, value|
        fields[name.downcase] = value.to_s.strip
      end
      fields
    end

    def clean_bib_value(value)
      compact_text(value.to_s
        .sub(/\A[\{"]/, '')
        .sub(/[\}"]\z/, '')
        .gsub(/[{}]/, '')
        .gsub(/\\[a-zA-Z]+\*?(?:\[[^\]]*\])?\s*/, '')
        .gsub('~', ' '))
    end
  end
end
