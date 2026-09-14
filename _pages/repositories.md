---
layout: page
title: Repositories
permalink: /repositories/
nav: false
---

<div class="signature-page-intro">
  <p class="signature-eyebrow">Open source</p>
  <p class="signature-page-deck">Selected public code repositories and software projects.</p>
</div>

{% if site.data.repositories.github_repos %}
<div class="repositories d-flex flex-wrap flex-md-row flex-column justify-content-between align-items-center signature-repositories">
  {% for repo in site.data.repositories.github_repos %}{% include repository/repo.liquid repository=repo %}{% endfor %}
</div>
{% endif %}
