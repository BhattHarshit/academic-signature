# Academic Signature

An academic website template build on [al-folio](https://github.com/alshedivat/al-folio) and [Jekyll](https://jekyllrb.com/) with a distinct profile-led design!

<p align="center">
  <a href="https://bhattharshit.github.io/academic-signature/">
    <img src="assets/img/demo.gif" alt="Academic Signature website demo" width="900">
  </a>
</p>

<p align="center">
  <a href="https://bhattharshit.github.io/academic-signature/"><strong>View Live Demo →</strong></a>
</p>

## Quick start

1. Click **Use this template → Create a new repository**.
2. Edit `_data/profile.yml` with your name, affiliation, website URL, social links, and CV settings.
3. Replace the example profile image, CV, publications, research, teaching, projects, news, and notes.
4. Preview locally:

   ```bash
   ./bin/setup
   ./bin/serve
   ```

5. Before publishing, run:

   ```bash
   ./bin/check
   ```

For a personal GitHub Pages site, name the repository `YOUR-USERNAME.github.io`. For a project site, use any repository name and set the matching `site.baseurl` in `_data/profile.yml`.

## What you normally edit

| Content | Location |
|---|---|
| Name, affiliation, links, site URL, CV settings | `_data/profile.yml` |
| Home and main pages | `_pages/` |
| Publications | `_bibliography/papers.bib` |
| Teaching | `_teachings/` |
| Projects | `_projects/` |
| News | `_news/` |
| Notes/blog | `_posts/` |
| Web CV | `_data/cv.yml` |
| Profile image | `assets/img/profile.png` |
| Official CV | `assets/pdf/` |

The example social handles are intentionally populated so the GitHub, LinkedIn, Google Scholar, and ORCID icons are visible in the starter. Replace them with your own values or leave an unused field blank.

### CV display

```yaml
cv:
  pdf: /assets/pdf/demo-cv.pdf
  website_view: false
```

- `false` embeds the official PDF and shows **Download CV**.
- `true` shows the web CV and provides **Download CV** and **Open PDF**.

## Highlights

- responsive profile-led academic layout with light and dark themes
- BibTeX publications with Jekyll Scholar
- compact publication and teaching views for longer academic records
- full-site search with highlighted matches and keyboard navigation
- embedded PDF CV or RenderCV-based web CV
- math, diagrams, charts, responsive images, repository cards, RSS, sitemap, SEO/OpenGraph, and comments
- automated validation and GitHub Pages deployment

## Contributing

Contributions are welcome. For substantial features or design changes, please open an issue first.

See [`.github/CONTRIBUTING.md`](.github/CONTRIBUTING.md) for the contribution workflow.

## Credits

Academic Signature directly builds on or uses:

- [al-folio](https://github.com/alshedivat/al-folio) — academic website foundation and plugin ecosystem, MIT License.
- [Jekyll](https://github.com/jekyll/jekyll) — static site generator, MIT License.
- [Jekyll Scholar](https://github.com/inukshuk/jekyll-scholar) — BibTeX bibliography integration, MIT License.
- [RenderCV](https://github.com/rendercv/rendercv) — optional web CV rendering, MIT License.
- [Font Awesome Free](https://github.com/FortAwesome/Font-Awesome) and [Academicons](https://github.com/jpswalsh/academicons) — interface and academic icons under their respective open-source licenses.

See [`NOTICE.md`](NOTICE.md) for attribution and license notes. Other dependencies are declared in the repository configuration files.

## Author and license

Academic Signature is created and maintained by [Harshit Bhatt](https://bhattharshit.github.io/).

The project is released under the MIT License. See [`LICENSE`](LICENSE) and [`NOTICE.md`](NOTICE.md). GitHub also reads [`CITATION.cff`](CITATION.cff) and provides a **Cite this repository** option.
