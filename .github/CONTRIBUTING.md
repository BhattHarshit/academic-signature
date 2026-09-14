# Contributing

Contributions are welcome. Keep changes focused and preserve the separation between Academic Signature's local presentation layer and the upstream al-folio runtime.

## Before opening a pull request

```bash
./bin/check
bundle exec al-folio upgrade audit --no-fail
bundle exec al-folio upgrade overrides audit
```

Review visual changes in light and dark modes at desktop and mobile widths.

## Where changes belong

- User-facing profile settings: `_data/profile.yml`
- Content: `_pages/`, `_projects/`, `_teachings/`, `_news/`, `_posts/`
- Visual system: `_sass/`
- Header, footer, and search presentation: `_includes/`
- Local generators: `_plugins/`

If a change belongs to al-folio itself, prefer contributing it upstream instead of copying additional runtime code into this repository.

Please preserve `LICENSE` and `NOTICE.md`.
