# Deployment

Academic Signature includes a GitHub Actions workflow that builds the site from `main` and deploys `_site` to the `gh-pages` branch.

## Configure the site URL

For a personal or organization site:

```yaml
# _data/profile.yml
site:
  url: https://USERNAME.github.io
  baseurl: ""
```

For a project site:

```yaml
site:
  url: https://USERNAME.github.io
  baseurl: /REPOSITORY-NAME
```

## Enable GitHub Pages

1. Push the repository to GitHub.
2. Wait for the **Deploy website** workflow to finish.
3. Open **Settings → Pages**.
4. Choose **Deploy from a branch**.
5. Select `gh-pages` and `/ (root)`.

The workflow uses Ruby 3.3.12, Python 3.13, ImageMagick, a production Jekyll build, PurgeCSS, and `JamesIves/github-pages-deploy-action`.

Before publishing a large customization or dependency update, run:

```bash
./bin/check
bundle exec al-folio upgrade audit --no-fail
bundle exec al-folio upgrade overrides audit
```
