# frozen_string_literal: true

# Academic Signature profile bridge.
#
# Keeps global identity/links in _data/profile.yml while translating them into
# the data structures expected by al-folio, jekyll-socials, jekyll-scholar,
# repository cards, RenderCV, and Giscus.
module AcademicSignature
  class ProfileBridge < Jekyll::Generator
    safe true
    priority :highest

    def generate(site)
      profile = site.data.fetch('profile', {})
      identity = profile.fetch('identity', {})
      settings = profile.fetch('site', {})

      first_name = identity['first_name']
      middle_name = identity['middle_name']
      last_name = identity['last_name']
      display_name = identity['display_name'].to_s.strip
      display_name = [first_name, middle_name, last_name].compact.reject { |v| v.to_s.strip.empty? }.join(' ') if display_name.empty?

      assign(site.config, 'title', settings['title'].to_s.strip.empty? ? display_name : settings['title'])
      assign(site.config, 'first_name', first_name)
      assign(site.config, 'middle_name', middle_name)
      assign(site.config, 'last_name', last_name)
      assign(site.config, 'contact_note', identity['contact_note'])
      assign(site.config, 'description', settings['description'])
      assign(site.config, 'keywords', Array(settings['keywords']).join(', '))
      assign(site.config, 'lang', settings['language'])
      site_url, baseurl = deployment_location(site, settings)
      assign(site.config, 'url', site_url)
      site.config['baseurl'] = baseurl.to_s

      # jekyll-socials assumes every present key has a meaningful value. Blank
      # optional handles are therefore removed instead of forwarded as nil/"".
      socials = clean_hash(profile.fetch('socials', {}))
      site.data['socials'] = socials
      site.data['repositories'] = clean_hash(profile.fetch('repositories', {}), recursive: true)
      site.data['repositories']['repo_description_lines_max'] ||= 2

      scholar = profile.fetch('scholar', {})
      site.config['scholar'] ||= {}
      site.config['scholar']['first_name'] = scholar['first_name'] if present?(scholar['first_name'])
      site.config['scholar']['last_name'] = scholar['last_name'] if present?(scholar['last_name'])

      blog = profile.fetch('blog', {})
      assign(site.config, 'blog_name', blog['name'])
      assign(site.config, 'blog_description', blog['description'])

      comments = clean_hash(profile.fetch('comments', {}))
      if present?(comments['repo'])
        site.config['giscus'] ||= {}
        comments.each { |key, value| site.config['giscus'][key] = value }
      end

      wire_cv(site, profile.fetch('cv', {}), identity, display_name, socials)
      apply_navigation_defaults(site)
    end

    private

    # Resolve GitHub Pages URLs during deployment.
    # Local previews keep their configured URLs.
    def deployment_location(site, settings)
      configured_url = settings['url'].to_s.strip
      configured_baseurl = settings['baseurl'].to_s

      unless ENV['ACADEMIC_SIGNATURE_PAGES_DEPLOY'] == 'true'
        return [configured_url, configured_baseurl]
      end

      owner, repo = ENV['GITHUB_REPOSITORY'].to_s.split('/', 2)

      if owner.to_s.empty? || repo.to_s.empty?
        return [configured_url, configured_baseurl]
      end

      # Respect an explicitly configured custom domain.
      cname_path = File.join(site.source, 'CNAME')

      if File.file?(cname_path)
        domain = File.read(cname_path).lines.first.to_s.strip

        if domain.match?(/\A[a-z0-9][a-z0-9.-]*\.[a-z]{2,}\z/i)
          return ["https://#{domain}", '']
        end
      end

      # Do not replace non-GitHub Pages domains.
      github_url = %r{\Ahttps?://[^/]+\.github\.io(?:/.*)?\z}i

      unless configured_url.empty? || configured_url.match?(github_url)
        return [configured_url, configured_baseurl]
      end

      baseurl = if repo.casecmp("#{owner}.github.io").zero?
                  ''
                else
                  "/#{repo}"
                end

      ["https://#{owner.downcase}.github.io", baseurl]
    end

    def present?(value)
      return false if value.nil?
      return !value.strip.empty? if value.is_a?(String)
      return !value.empty? if value.respond_to?(:empty?)

      true
    end

    def clean_hash(hash, recursive: false)
      hash.each_with_object({}) do |(key, value), cleaned|
        next unless present?(value)

        cleaned[key] = recursive && value.is_a?(Hash) ? clean_hash(value, recursive: true) : value
      end
    end

    def assign(config, key, value)
      config[key] = value if present?(value)
    end

    def wire_cv(site, cv_options, identity, display_name, socials)
      cv_data = site.data['cv']
      if cv_data.is_a?(Hash) && cv_data['cv'].is_a?(Hash)
        cv = cv_data['cv']
        cv['name'] = display_name if present?(display_name)
        cv['email'] = identity['email'] if present?(identity['email'])
        cv['location'] = identity['location'] if present?(identity['location'])

        networks = []
        networks << { 'network' => 'GitHub', 'username' => socials['github_username'] } if present?(socials['github_username'])
        networks << { 'network' => 'LinkedIn', 'username' => socials['linkedin_username'] } if present?(socials['linkedin_username'])
        cv['social_networks'] = networks unless networks.empty?
      end

      cv_page = site.pages.find { |page| page.data['permalink'] == '/cv/' }
      return unless cv_page

      cv_pdf = cv_options['pdf']
      cv_pdf = socials['cv_pdf'] if !present?(cv_pdf) && present?(socials['cv_pdf'])
      cv_page.data['cv_pdf'] = cv_pdf if present?(cv_pdf)
    end

    # A new Markdown file under _pages becomes a navbar tab unless nav: false is
    # explicitly set. Content pages stay self-contained; no menu file to update.
    def apply_navigation_defaults(site)
      site.pages.each do |page|
        next unless page.path.to_s.start_with?('_pages/')
        next if page.data.key?('nav')
        next if page.data['permalink'] == '/'
        next unless present?(page.data['title'])

        page.data['nav'] = true
        page.data['nav_order'] ||= 50
      end
    end
  end
end
