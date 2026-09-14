# Academic Signature

A polished, research-first academic website template built on [al-folio](https://github.com/alshedivat/al-folio) and [Jekyll](https://jekyllrb.com/). Academic Signature combines a distinctive profile-led layout with publications, teaching, projects, news, CV support, full-site search, math and diagrams, light/dark themes, and GitHub Pages deployment while keeping routine personalization simple.

<p align="center">
  <a href="https://bhattharshit.github.io/academic-signature/">
    <img src="assets/img/demo.gif" alt="Academic Signature website demo" width="900">
  </a>
</p>

<p align="center">
  <a href="https://bhattharshit.github.io/academic-signature/"><strong>View Live Demo →</strong></a>
</p>

> Add the repository demo GIF at `assets/img/demo.gif`.

## Quick start

1. Click **Use this template → Create a new repository**.
2. Edit **`_data/profile.yml`** with your identity, institution, website URL, social handles, and CV settings.
3. Replace **`assets/img/profile.png`** and the example PDF in **`assets/pdf/`**.
4. Replace the example research, publications, teaching, projects, news, and notes.
5. Preview locally:

   ```bash
   ./bin/setup
   ./bin/serve
   ```

6. Before publishing, run `./bin/check`, push to GitHub, and enable GitHub Pages from the generated `gh-pages` branch.

For a personal GitHub Pages site, name the repository `YOUR-USERNAME.github.io`. For a project site, use any repository name and set `site.baseurl` in `_data/profile.yml`.

All bundled names, institutions, publications, courses, projects, accounts, and CV entries are examples intended to be replaced.

## What you normally edit

| Content | Location |
|---|---|
| Name, affiliation, links, site URL, CV mode | `_data/profile.yml` |
| Home and main pages | `_pages/` |
| Publications | `_bibliography/papers.bib` |
| Teaching | `_teachings/` |
| Projects | `_projects/` |
| News | `_news/` |
| Notes/blog | `_posts/` |
| Web CV | `_data/cv.yml` |
| Profile image | `assets/img/profile.png` |
| Official CV PDF | `assets/pdf/` |

The example social handles in `_data/profile.yml` are populated so GitHub, LinkedIn, Google Scholar, and ORCID icons are visible in the starter. Replace them with your own values, or set an unused entry to `""`.

The CV supports two modes:

```yaml
cv:
  pdf: /assets/pdf/demo-cv.pdf
  website_view: false
```

- `false`: embed the official PDF and show **Download CV**.
- `true`: show the web CV with **Download CV** and **Open PDF**.

## Local preview

```bash
./bin/setup
./bin/serve
```

Open `http://127.0.0.1:4000/`.

Before publishing changes:

```bash
./bin/check
```

## Repository layout

```text
_data/               profile and web-CV data
_pages/              main pages
_bibliography/       publications
_projects/           project entries
_teachings/          teaching entries
_news/               short updates
_posts/              notes and blog posts
assets/               images, PDFs, favicons, and runtime assets
bin/                  setup, preview, and validation commands
_academic_signature/ technical documentation and maintenance helpers
```

The standard Jekyll override folders (`_includes/`, `_layouts/`, `_plugins/`, and `_sass/`) contain implementation code and normally do not need editing for routine profile or content updates.

## Features

- responsive academic layout with light and dark themes
- BibTeX publications with Jekyll Scholar
- compact publication and teaching views for long academic records
- full-site text search with highlighted matches and keyboard navigation
- embedded PDF CV or RenderCV-based web CV
- MathJax/TikZ, diagrams and charts, responsive images, repository cards, RSS, sitemap, SEO/OpenGraph, and comments
- automated checks and GitHub Pages deployment

## Contributing

Contributions are welcome. For small fixes and improvements, feel free to open a pull request. For substantial features or design changes, please open an issue first so the idea can be discussed before implementation.

See [`.github/CONTRIBUTING.md`](.github/CONTRIBUTING.md) for the contribution workflow and project guidelines.

## Credits

Academic Signature directly builds on or uses:

- [al-folio](https://github.com/alshedivat/al-folio) — academic website foundation and plugin ecosystem, MIT License.
- [Jekyll](https://github.com/jekyll/jekyll) — static site generator, MIT License.
- [Jekyll Scholar](https://github.com/inukshuk/jekyll-scholar) — BibTeX bibliography integration, MIT License.
- [RenderCV](https://github.com/rendercv/rendercv) — optional web CV rendering, MIT License.
- [Font Awesome Free](https://github.com/FortAwesome/Font-Awesome) and [Academicons](https://github.com/jpswalsh/academicons) — interface and academic icons under their respective open-source licenses.

See [`NOTICE.md`](NOTICE.md) for attribution and license notes. Other dependencies are declared in `Gemfile`, `_academic_signature/requirements.txt`, `_config.yml`, and `.github/workflows/`.

## Author, citation, and license

Academic Signature is created and maintained by [Harshit Bhatt](https://bhattharshit.github.io/).

GitHub reads [`CITATION.cff`](CITATION.cff) and provides a **Cite this repository** option. Academic Signature is released under the MIT License; see [`LICENSE`](LICENSE) and [`NOTICE.md`](NOTICE.md).
