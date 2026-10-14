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
1. Create a GitHub account if you don't have one and login with that.
2. Click **Use this template** on the top right corner.
3. Create a **new repository** and name it: `your_Github_username.github.io`
4. Open **Settings → Pages** and under **Build and deployment**, set **Source** to **GitHub Actions**.
5. Edit `data/profile.yml` slightly and commit changes. (OR, Open **Actions → Deploy Hugo site to GitHub Pages → Run workflow**.)
6. Your website will be available at:  `https://your_Github_username.github.io/`
7. Edit `data/profile.yml` and `data/cv.yml` to update your information and update your data inside `assets/`.

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
