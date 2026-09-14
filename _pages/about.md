---
layout: default
title: Home
permalink: /
nav: false
---

{% assign identity = site.data.profile.identity %}
{% assign profile = site.data.profile.profile %}
{% assign avatar_path = profile.image | prepend: 'assets/img/' %}

<div class="signature-home">
  <aside class="signature-profile-rail" aria-label="Profile">
    <div class="signature-profile-card">
      <div class="signature-avatar-wrap">
        {% include figure.liquid loading="eager" path=avatar_path class="signature-avatar" sizes="(max-width: 860px) 160px, 260px" alt=profile.image_alt %}
        <span class="signature-status-dot" title="{{ profile.availability }}" aria-hidden="true"></span>
      </div>

      <div class="signature-profile-copy">
        <h1>{{ identity.display_name }}</h1>
        <p class="signature-role">{{ identity.role }}</p>
        <p class="signature-affiliation">
          {% if identity.affiliation_url %}<a href="{{ identity.affiliation_url }}">{{ identity.affiliation }}</a>{% else %}{{ identity.affiliation }}{% endif %}
        </p>
        <p class="signature-department">{{ identity.department }}</p>
      </div>

      <div class="signature-profile-meta">
        {% if identity.location %}<span><i class="fa-solid fa-location-dot" aria-hidden="true"></i>{{ identity.location }}</span>{% endif %}
        {% if identity.research_line %}<span><i class="fa-solid fa-wave-square" aria-hidden="true"></i>{{ identity.research_line }}</span>{% endif %}
      </div>

      <div class="signature-socials" aria-label="Professional links">{% social_links %}</div>
      {% if profile.availability %}<p class="signature-availability"><span></span>{{ profile.availability }}</p>{% endif %}
    </div>
  </aside>

  <section class="signature-home-main">
    <section class="signature-about-section">
      <p class="signature-eyebrow">About</p>
      <h2>Mathematics that scales from structure to computation.</h2>
      <p class="signature-lead">
        I work at the intersection of mathematical modeling and computation, with interests in <strong>scientific computing</strong>, <strong>numerical linear algebra</strong>, <strong>inverse problems</strong>, and <strong>randomized algorithms</strong>. My work focuses on methods that are mathematically principled, computationally scalable, and useful for challenging scientific problems.
      </p>
      <p class="signature-lead signature-lead-secondary">
        I am particularly interested in discovering and exploiting structure in large operators, developing adaptive algorithms, and connecting numerical linear algebra with scientific models, optimization, and uncertainty quantification.
      </p>
    </section>

    {% assign recent_news = site.news | sort: 'date' | reverse %}
    {% if recent_news.size > 0 %}
      <section class="signature-home-section signature-home-news">
        <div class="signature-section-heading">
          <div><p class="signature-eyebrow">News</p><h3>Recent updates</h3></div>
          <a href="{{ '/news/' | relative_url }}">See more <i class="fa-solid fa-arrow-right" aria-hidden="true"></i></a>
        </div>
        <div class="signature-update-list">
          {% for item in recent_news limit: 5 %}
            <article class="signature-update-item">
              <time datetime="{{ item.date | date_to_xmlschema }}">{{ item.date | date: '%b %Y' }}</time>
              <div>
                {% if item.title and item.inline != true %}<a class="signature-update-title" href="{{ item.url | relative_url }}">{{ item.title }}</a>{% endif %}
                <div>{{ item.content }}</div>
              </div>
            </article>
          {% endfor %}
        </div>
      </section>
    {% endif %}
  </section>
</div>
