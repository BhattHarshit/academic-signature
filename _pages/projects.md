---
layout: page
title: Projects
permalink: /projects/
nav: true
nav_order: 4
display_categories: [research, software]
horizontal: false
---

<div class="signature-page-intro">
  <p class="signature-eyebrow">Projects</p>
  <p class="signature-page-deck">Selected research projects, scientific software, and reproducible computational work.</p>
</div>

<div class="projects signature-projects">
  {% if site.enable_project_categories and page.display_categories %}
    {% for category in page.display_categories %}
      <div class="signature-category-heading"><span>{{ category }}</span></div>
      {% assign categorized_projects = site.projects | where: 'category', category %}
      {% assign sorted_projects = categorized_projects | sort: 'importance' %}
      <div class="row row-cols-1 row-cols-md-2 g-4 signature-project-grid">
        {% for project in sorted_projects %}
          {% include projects.liquid %}
        {% endfor %}
      </div>
    {% endfor %}
  {% else %}
    {% assign sorted_projects = site.projects | sort: 'importance' %}
    <div class="row row-cols-1 row-cols-md-2 g-4 signature-project-grid">
      {% for project in sorted_projects %}
        {% include projects.liquid %}
      {% endfor %}
    </div>
  {% endif %}
</div>
