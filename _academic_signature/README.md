# Academic Signature internals

This folder keeps maintenance files that most site owners do not need during routine editing.

Use the repository root for normal website updates:

- `_data/profile.yml` — name, affiliation, links, site URL, social handles, and CV settings
- `_pages/` — main pages
- `_bibliography/` — publications
- `_projects/`, `_teachings/`, `_news/`, `_posts/` — academic content
- `assets/img/profile.png` and `assets/pdf/` — profile image and official CV

Files in this folder support development, documentation, and release maintenance:

```text
docs/                 customization, local-development, deployment, and design notes
tools/                repository validation helpers
requirements.txt      Python dependencies used by optional tooling
purgecss.config.js    production CSS cleanup configuration
CHANGELOG.md           release history
START_HERE.md          extended setup walkthrough
```

The Jekyll implementation remains in the conventional `_includes/`, `_layouts/`, `_plugins/`, and `_sass/` folders so theme overrides and al-folio upgrade tooling continue to work as expected.
