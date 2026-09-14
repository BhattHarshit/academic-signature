---
layout: page
title: News
permalink: /news/
nav: true
nav_order: 5
description: Research, teaching, software, talks, awards, and academic updates.
---

<div class="signature-page-intro">
  <p class="signature-eyebrow">News</p>
  <p class="signature-page-deck">Research, teaching, software, talks, awards, and other academic updates.</p>
</div>

{% assign news_items = site.news | sort: 'date' | reverse %}
<div class="signature-news-archive">
  {% for item in news_items %}
    <article class="signature-news-entry">
      <time datetime="{{ item.date | date_to_xmlschema }}">
        <span>{{ item.date | date: '%b' }}</span>
        <strong>{{ item.date | date: '%d' }}</strong>
        <small>{{ item.date | date: '%Y' }}</small>
      </time>
      <div class="signature-news-entry-body">
        {% if item.title %}
          <h2>
            {% if item.inline == true %}{{ item.title }}{% else %}<a href="{{ item.url | relative_url }}">{{ item.title }}</a>{% endif %}
          </h2>
        {% endif %}
        <div>{{ item.content }}</div>
        {% unless item.inline == true %}
          <a class="signature-text-link" href="{{ item.url | relative_url }}">
            Read update <i class="fa-solid fa-arrow-right" aria-hidden="true"></i>
          </a>
        {% endunless %}
      </div>
    </article>
  {% endfor %}
</div>
