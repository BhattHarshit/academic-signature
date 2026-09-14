---
layout: page
title: Sitemap
permalink: /sitemap/
nav: false
sitemap: false
search: false
---

<div class="signature-page-intro">
  <p class="signature-eyebrow">Explore</p>
  <p class="signature-page-deck">A structured overview of the website, with direct routes to primary pages and detailed academic content.</p>
</div>

<div class="signature-sitemap-grid">
  <section class="signature-sitemap-card">
    <span class="signature-sitemap-icon"><i class="fa-solid fa-compass" aria-hidden="true"></i></span>
    <h2>Main pages</h2>
    <ul>
      <li><a href="{{ '/' | relative_url }}"><strong>Home</strong><span>Profile, about, and recent updates</span></a></li>
      {% assign sitemap_pages = site.pages | where: 'nav', true | sort: 'nav_order' %}
      {% for item in sitemap_pages %}
        <li><a href="{{ item.url | relative_url }}"><strong>{{ item.title }}</strong>{% if item.description %}<span>{{ item.description }}</span>{% endif %}</a></li>
      {% endfor %}
      {% if site.posts.size > 0 %}<li><a href="{{ '/blog/' | relative_url }}"><strong>Notes</strong><span>Research notes and longer updates</span></a></li>{% endif %}
      {% if site.data.repositories.github_repos %}<li><a href="{{ '/repositories/' | relative_url }}"><strong>Repositories</strong><span>Selected public code repositories</span></a></li>{% endif %}
    </ul>
  </section>

  {% if site.projects.size > 0 %}
  <section class="signature-sitemap-card">
    <span class="signature-sitemap-icon"><i class="fa-solid fa-diagram-project" aria-hidden="true"></i></span>
    <h2>Projects</h2>
    <ul>
      {% assign sitemap_projects = site.projects | sort: 'importance' %}
      {% for item in sitemap_projects %}
        <li><a href="{{ item.url | relative_url }}"><strong>{{ item.title }}</strong>{% if item.description %}<span>{{ item.description }}</span>{% endif %}</a></li>
      {% endfor %}
    </ul>
  </section>
  {% endif %}

  {% if site.teachings.size > 0 %}
  <section class="signature-sitemap-card">
    <span class="signature-sitemap-icon"><i class="fa-solid fa-chalkboard-user" aria-hidden="true"></i></span>
    <h2>Teaching</h2>
    <ul>
      {% assign sitemap_teaching = site.teachings | sort: 'date' | reverse %}
      {% for item in sitemap_teaching %}
        <li><a href="{{ item.url | relative_url }}"><strong>{{ item.title }}</strong>{% if item.term %}<span>{{ item.term }}{% if item.institution %} · {{ item.institution }}{% endif %}</span>{% endif %}</a></li>
      {% endfor %}
    </ul>
  </section>
  {% endif %}

  {% if site.news.size > 0 %}
  <section class="signature-sitemap-card">
    <span class="signature-sitemap-icon"><i class="fa-regular fa-newspaper" aria-hidden="true"></i></span>
    <h2>Recent news</h2>
    <ul>
      {% assign sitemap_news = site.news | sort: 'date' | reverse %}
      {% for item in sitemap_news limit: 8 %}
        {% if item.inline == true %}
          <li class="signature-sitemap-static"><strong>{{ item.title | default: 'Update' }}</strong><span>{{ item.date | date: '%B %Y' }}</span></li>
        {% else %}
          <li><a href="{{ item.url | relative_url }}"><strong>{{ item.title | default: 'Update' }}</strong><span>{{ item.date | date: '%B %Y' }}</span></a></li>
        {% endif %}
      {% endfor %}
    </ul>
  </section>
  {% endif %}
</div>

<p class="signature-sitemap-machine">For search engines and automated tools, the machine-readable XML sitemap remains available at <a href="{{ '/sitemap.xml' | relative_url }}">sitemap.xml</a>.</p>
