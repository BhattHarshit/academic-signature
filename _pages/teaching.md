---
layout: page
title: Teaching
permalink: /teaching/
nav: true
nav_order: 3
description: Courses, mentoring, and teaching materials.
---

<div class="signature-page-intro">
  <p class="signature-eyebrow">Teaching</p>
  <p class="signature-page-deck">Courses, instructional roles, mentoring, and selected teaching materials.</p>
</div>

{% assign sorted_teachings = site.teachings | sort: 'date' | reverse %}
{% assign teaching_groups = sorted_teachings | group_by: 'institution' %}

<div class="signature-teaching-groups">
  {% for group in teaching_groups %}
    <section class="signature-teaching-group">
      <h2>{{ group.name | default: 'Teaching' }}</h2>
      <div class="signature-teaching-list">
        {% for item in group.items %}
          <article class="signature-teaching-row">
            <div class="signature-teaching-row-main">
              <h3><a href="{{ item.url | relative_url }}">{{ item.title }}</a></h3>
              <p>
                {% if item.term %}{{ item.term }}{% endif %}
                {% if item.term and item.role %}<span aria-hidden="true"> · </span>{% endif %}
                {% if item.role %}{{ item.role }}{% endif %}
              </p>
            </div>
            <a class="signature-row-arrow" href="{{ item.url | relative_url }}" aria-label="View {{ item.title }} details">
              <i class="fa-solid fa-arrow-right" aria-hidden="true"></i>
            </a>
          </article>
        {% endfor %}
      </div>
    </section>
  {% endfor %}
</div>
