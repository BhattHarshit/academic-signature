# Start Here

Academic Signature is designed so routine setup happens in one file plus the academic content folders.

## 1. Create your repository

On GitHub, choose **Use this template → Create a new repository**.

For a personal GitHub Pages site, use:

```text
YOUR-USERNAME.github.io
```

## 2. Edit the global profile

Open `_data/profile.yml` and replace the example name, institution, email, site URL, social handles, and CV settings.

The starter includes example GitHub, LinkedIn, Google Scholar, and ORCID handles so their icons are visible. Replace them with your own values, or use `""` for any service you do not use.

## 3. Replace the demo files

```text
assets/img/profile.png
assets/pdf/demo-cv.pdf
```

## 4. Replace the example content

```text
_pages/research.md
_bibliography/papers.bib
_teachings/
_projects/
_news/
_posts/
```

Delete any example entries you do not need.

## 5. Preview locally

Run setup once:

```bash
./bin/setup
```

Then start the development server:

```bash
./bin/serve
```

Open `http://127.0.0.1:4000/`.

## 6. Publish

Push to GitHub and follow [`docs/DEPLOYMENT.md`](docs/DEPLOYMENT.md).

For additional options, see [`docs/README.md`](docs/README.md).
