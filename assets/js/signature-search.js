(() => {
  const root = document.getElementById('signature-search');
  const openButton = document.getElementById('search-toggle');
  if (!root || !openButton) return;

  const dialog = root.querySelector('.signature-search-dialog');
  const input = root.querySelector('#signature-search-input');
  const resultsEl = root.querySelector('#signature-search-results');
  const statusEl = root.querySelector('#signature-search-status');
  const closeButtons = root.querySelectorAll('[data-search-close]');
  const filterButtons = root.querySelectorAll('[data-search-filter]');
  const indexUrl = root.dataset.indexUrl;
  const maxResults = Number(root.dataset.maxResults || 14);

  let index = [];
  let activeFilter = 'All';
  let activeResult = -1;
  let lastFocused = null;
  let loadPromise = null;

  const normalize = (value) => String(value || '')
    .normalize('NFKD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase();

  const escapeHtml = (value) => String(value || '')
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;');

  const tokenize = (query) => normalize(query).split(/\s+/).filter(Boolean);

  const highlight = (value, tokens) => {
    let html = escapeHtml(value);
    [...tokens].sort((a, b) => b.length - a.length).forEach((token) => {
      if (!token) return;
      const safe = token.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
      html = html.replace(new RegExp(`(${safe})`, 'ig'), '<mark>$1</mark>');
    });
    return html;
  };

  const makeSnippet = (record, tokens) => {
    const source = record.text || record.description || '';
    const normalized = normalize(source);
    let hit = -1;
    tokens.forEach((token) => {
      const at = normalized.indexOf(token);
      if (at >= 0 && (hit < 0 || at < hit)) hit = at;
    });
    if (hit < 0) return record.description || source.slice(0, 190);
    const radius = 105;
    const start = Math.max(0, hit - radius);
    const end = Math.min(source.length, hit + radius);
    return `${start > 0 ? '…' : ''}${source.slice(start, end).trim()}${end < source.length ? '…' : ''}`;
  };

  const scoreRecord = (record, tokens) => {
    const title = normalize(record.title);
    const description = normalize(record.description);
    const text = normalize(record.text);
    const keywords = normalize((record.keywords || []).join(' '));
    let score = 0;
    for (const token of tokens) {
      const found = title.includes(token) || description.includes(token) || text.includes(token) || keywords.includes(token);
      if (!found) return -1;
      if (title === token) score += 30;
      else if (title.startsWith(token)) score += 20;
      else if (title.includes(token)) score += 14;
      if (description.includes(token)) score += 7;
      if (keywords.includes(token)) score += 5;
      if (text.includes(token)) score += 2;
    }
    return score;
  };

  const loadIndex = () => {
    if (loadPromise) return loadPromise;
    loadPromise = fetch(indexUrl, { credentials: 'same-origin' })
      .then((response) => {
        if (!response.ok) throw new Error(`Search index returned ${response.status}`);
        return response.json();
      })
      .then((data) => { index = Array.isArray(data) ? data : []; })
      .catch(() => {
        statusEl.textContent = 'Search index could not be loaded. Rebuild the site and try again.';
        index = [];
      });
    return loadPromise;
  };

  const renderEmpty = (message) => {
    activeResult = -1;
    resultsEl.innerHTML = `<div class="signature-search-empty"><i class="fa-regular fa-compass" aria-hidden="true"></i><p>${escapeHtml(message)}</p></div>`;
  };

  const updateActiveResult = (next) => {
    const links = [...resultsEl.querySelectorAll('.signature-search-result')];
    if (!links.length) return;
    activeResult = (next + links.length) % links.length;
    links.forEach((link, i) => link.classList.toggle('is-active', i === activeResult));
    links[activeResult].scrollIntoView({ block: 'nearest' });
  };

  const runSearch = () => {
    const query = input.value.trim();
    const tokens = tokenize(query);
    if (!tokens.length) {
      statusEl.textContent = '';
      statusEl.classList.add('is-empty');
      resultsEl.innerHTML = '';
      activeResult = -1;
      return;
    }

    const matches = index
      .filter((record) => activeFilter === 'All' || record.type === activeFilter)
      .map((record) => ({ record, score: scoreRecord(record, tokens) }))
      .filter((item) => item.score >= 0)
      .sort((a, b) => b.score - a.score || String(a.record.title).localeCompare(String(b.record.title)))
      .slice(0, maxResults);

    statusEl.classList.remove('is-empty');
    statusEl.textContent =
      `${matches.length}${matches.length === maxResults ? '+' : ''} result${matches.length === 1 ? '' : 's'} for “${query}”`;
    activeResult = -1;

    if (!matches.length) {
      renderEmpty('No direct match. Try fewer words or a broader term.');
      return;
    }

    resultsEl.innerHTML = matches.map(({ record }) => {
      const snippet = makeSnippet(record, tokens);
      return `<a class="signature-search-result" href="${escapeHtml(record.url)}">
        <span class="signature-search-result-topline">
          <span class="signature-search-result-type">${escapeHtml(record.type)}</span>
          ${record.date ? `<time>${escapeHtml(String(record.date).slice(0, 10))}</time>` : ''}
        </span>
        <strong>${highlight(record.title, tokens)}</strong>
        <span class="signature-search-result-snippet">${highlight(snippet, tokens)}</span>
      </a>`;
    }).join('');
  };

  const openSearch = async () => {
    lastFocused = document.activeElement;
    root.hidden = false;
    document.documentElement.classList.add('signature-search-open');
    dialog.setAttribute('aria-modal', 'true');
    statusEl.textContent = '';
    statusEl.classList.add('is-empty');
    resultsEl.innerHTML = '';
    await loadIndex();
    runSearch();
    requestAnimationFrame(() => input.focus());
  };

  const closeSearch = () => {
    root.hidden = true;
    document.documentElement.classList.remove('signature-search-open');
    input.value = '';
    statusEl.textContent = '';
    statusEl.classList.add('is-empty');
    resultsEl.innerHTML = '';
    activeFilter = 'All';
    filterButtons.forEach((button) => {
      const active = button.dataset.searchFilter === 'All';
      button.classList.toggle('is-active', active);
      button.setAttribute('aria-pressed', active ? 'true' : 'false');
    });
    if (lastFocused && typeof lastFocused.focus === 'function') lastFocused.focus();
  };

  openButton.addEventListener('click', openSearch);
  closeButtons.forEach((button) => button.addEventListener('click', closeSearch));
  input.addEventListener('input', runSearch);

  filterButtons.forEach((button) => {
    button.addEventListener('click', () => {
      activeFilter = button.dataset.searchFilter;
      filterButtons.forEach((candidate) => {
        const active = candidate === button;
        candidate.classList.toggle('is-active', active);
        candidate.setAttribute('aria-pressed', active ? 'true' : 'false');
      });
      runSearch();
      input.focus();
    });
  });

  document.addEventListener('keydown', (event) => {
    if ((event.metaKey || event.ctrlKey) && event.key.toLowerCase() === 'k') {
      event.preventDefault();
      root.hidden ? openSearch() : closeSearch();
      return;
    }
    if (root.hidden) return;
    if (event.key === 'Escape') {
      event.preventDefault();
      closeSearch();
    } else if (event.key === 'ArrowDown') {
      event.preventDefault();
      updateActiveResult(activeResult + 1);
    } else if (event.key === 'ArrowUp') {
      event.preventDefault();
      updateActiveResult(activeResult - 1);
    } else if (event.key === 'Enter' && activeResult >= 0) {
      const links = resultsEl.querySelectorAll('.signature-search-result');
      if (links[activeResult]) {
        event.preventDefault();
        links[activeResult].click();
      }
    }
  });
})();
