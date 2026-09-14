# Local development

## Requirements

- Ruby 3.3.x
- Python 3.13
- ImageMagick 7

The recommended Ruby and Python versions are recorded in `.ruby-version` and `.python-version`.

## First setup

From the repository root:

```bash
./bin/setup
```

This installs Ruby dependencies with Bundler and Python dependencies from `_academic_signature/requirements.txt` in a local `.venv`.

Verify ImageMagick separately:

```bash
magick -version
```

## Preview

```bash
./bin/serve
```

Open `http://127.0.0.1:4000/`.

`bin/serve` activates `.venv` when it exists and starts Jekyll with LiveReload. The development-only `_plugins/local_dev_webrick.rb` filters two browser-connection messages that can appear during local refreshes: `Errno::ECONNRESET` and `WEBrick::HTTPStatus::RequestRangeNotSatisfiable`. Other server and build errors remain visible.

To run Jekyll directly:

```bash
bundle exec jekyll serve --livereload
```

## Validate the project

```bash
./bin/check
```

This runs the repository checks and a complete Jekyll build.

## Clean rebuild

```bash
bundle exec jekyll clean
./bin/serve
```

## Ruby on macOS

Avoid Apple's protected system Ruby. If `which ruby` prints `/usr/bin/ruby`, install a current Ruby 3.3.x with Homebrew or a Ruby version manager before running Bundler.
