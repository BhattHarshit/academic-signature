# Academic Signature design notes

Academic Signature is organized around what an academic visitor normally needs first: identity, research, scholarship, teaching, projects, current news, and a trustworthy CV.

## Visual structure

- **Navigation:** centered within the same 1180px canvas as the homepage. The identity sits approximately over the left profile rail rather than at the viewport edge.
- **Homepage:** sticky profile rail on the left; a deliberately quiet About narrative and Recent Updates on the right. Primary navigation is not duplicated as a second card menu.
- **Research:** long-form mathematical writing with strong typography, cards, TOC support, figures, code, and display mathematics.
- **Publications:** BibTeX/Jekyll Scholar remains the authoritative data source; no redundant CV promotion appears on the page.
- **Teaching:** compact institution-grouped course list linked to independent course detail pages, designed to scale to many entries.
- **Projects:** visual collection cards linked to independent project detail pages.
- **News:** chronological academic update archive; latest entries surface automatically on the homepage.
- **CV:** one heading, official PDF embedded by default, optional web CV, and context-aware actions (Open PDF appears only in website-view mode).
- **Search:** full-text Academic Signature search with snippets, highlighting, stable individual filter pills, and keyboard access.
- **Sitemap:** human-facing navigational sitemap plus standards-compliant XML sitemap for crawlers.
- **Footer:** compact, bottom-anchored, neutral in both themes.

## Motion and stability

The header uses a reserved fixed height and the document uses a stable scrollbar gutter. Detail-page return navigation is fixed at the upper-left outside normal layout flow. Together these prevent the small page-to-page vertical/horizontal shifts that otherwise make navigation feel unstable.

## Theme behavior

The underlying al-folio theme runtime resolves system preference on first load. Academic Signature exposes only explicit Light/Dark controls afterward; the three-state system icon is intentionally not part of the UI.

## Accessibility and usability

The design includes skip-to-content, visible keyboard focus, reduced-motion behavior, semantic navigation labels, responsive breakpoints, print cleanup, clear active states, keyboard-accessible full-text search, and section-return links for detail pages.

## Runtime boundary

Academic Signature avoids copying feature runtimes that already belong to the al-folio plugin ecosystem. Site-specific behavior that is materially different—such as the complete-content search index—is implemented locally and documented as part of Academic Signature.
