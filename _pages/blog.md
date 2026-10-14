---
layout: default
permalink: /blog/
title: Notes
nav: true
pagination:
  enabled: true
  collection: posts
  permalink: /page/:num/
  per_page: 8
  sort_field: date
  sort_reverse: true
---

<div class="signature-blog">
  <div class="signature-page-intro">
    <p class="signature-eyebrow">{{ site.blog_name }}</p>
    <h1>Notes, ideas, and updates.</h1>
    <p class="signature-page-deck">{{ site.blog_description }}</p>
  </div>

  {% if site.display_tags.size > 0 %}
    <div class="signature-chip-row signature-blog-tags">
      {% for tag in site.display_tags %}
        <a href="{{ tag | slugify | prepend: '/blog/tag/' | relative_url }}">#{{ tag }}</a>
      {% endfor %}
    </div>
  {% endif %}

  <div class="signature-blog-list">
    {% if page.pagination.enabled %}
      {% assign postlist = paginator.posts %}
    {% else %}
      {% assign postlist = site.posts %}
    {% endif %}

    {% for post in postlist %}
      {% assign read_time = post.content | number_of_words | divided_by: 180 | plus: 1 %}
      <article class="signature-blog-item">
        <div class="signature-blog-date">
          <span>{{ post.date | date: '%b' }}</span>
          <strong>{{ post.date | date: '%d' }}</strong>
          <small>{{ post.date | date: '%Y' }}</small>
        </div>
        <div>
          <p class="signature-blog-meta">{{ read_time }} min read{% if post.tags %} · {{ post.tags | join: ' · ' }}{% endif %}</p>
          <h2><a href="{{ post.url | relative_url }}">{{ post.title }}</a></h2>
          <p>{{ post.description }}</p>
          <a class="signature-text-link" href="{{ post.url | relative_url }}">
            Read note <i class="fa-solid fa-arrow-right" aria-hidden="true"></i>
          </a>
        </div>
      </article>
    {% endfor %}
  </div>

  {% if page.pagination.enabled %}
    {% include pagination.liquid %}
  {% endif %}
</div>
