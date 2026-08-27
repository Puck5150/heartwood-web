# Heartwood Marketing Site Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the four-page static Heartwood marketing site (Landing, Pricing, About, Download) as an Astro project matching `docs/superpowers/specs/2026-08-07-heartwood-marketing-site-design.md`.

**Architecture:** Static-generated Astro site, no backend, no CMS. One shared `BaseLayout` wraps `Nav`/`Footer`; four thin page files; one interactive island (`GreenhouseDemo`) built on a pure, unit-tested capture function; design tokens centralized in `tokens.css`; fonts self-hosted via `@fontsource`.

**Tech Stack:** Astro (static output), vanilla JS (no UI framework), vitest for the one unit-testable module, `@fontsource/fraunces` + `@fontsource/public-sans` for self-hosted fonts.

## Global Constraints

- Local-first promise stated plainly, not as a footnote: no accounts, no telemetry, no ads, no cloud.
- Never mention sync or mobile anywhere on the site — neither exists.
- Invent nothing: no fake testimonials, download counts, user quotes, or fabricated screenshots. Real assets (screen recording, OS download links) get clearly marked placeholders, never styled as if real.
- Visual defaults to avoid: purple gradients, Inter typeface, nested card soup, three-icon hero rows, urgency/countdown language, "10x your output" framing.
- Tone: quiet, warm, a little wooded. Restraint over polish.
- Mission statement on the About page must be reproduced verbatim (see spec) — no paraphrasing.
- Free tier: timer, unlimited Greenhouse captures, one soundscape, no account required.
- Paid tier: $19 one-time (early adopter price, rising to $29 at 1.0) — all soundscapes, versioned history, markdown notes, export, session analytics, unlimited devices you own.
- Palette: background `#F7F2EA`, alt background `#EFE7D8`, ink `#2A2119`, accent `#8B5A3C`, secondary accent `#B5613C`.
- Fonts: Fraunces (headings), Public Sans (body) — self-hosted, no third-party font CDN request.
- Breakpoint for single-column stack: below 700px.

---

### Task 1: Project scaffold, design tokens, fonts

**Files:**
- Create: `package.json`
- Create: `astro.config.mjs`
- Create: `tsconfig.json`
- Create: `src/styles/tokens.css`
- Create: `src/pages/index.astro` (temporary minimal page — replaced in Task 4)
- Create: `.gitignore`

**Interfaces:**
- Consumes: nothing (first task).
- Produces: CSS custom properties in `tokens.css` — `--color-bg`, `--color-bg-alt`, `--color-ink`, `--color-accent`, `--color-accent-secondary`, `--color-border`, `--font-heading`, `--font-body`, `--space-1` through `--space-8`, `--breakpoint-stack: 700px`. Later tasks import this file via `import '../styles/tokens.css'` (or link in `BaseLayout`) and use these variable names verbatim.

- [x] **Step 1: Write `package.json`**

```json
{
  "name": "heartwood-web",
  "type": "module",
  "version": "0.0.1",
  "private": true,
  "scripts": {
    "dev": "astro dev",
    "build": "astro build",
    "preview": "astro preview",
    "test": "vitest run"
  },
  "dependencies": {
    "astro": "^4.15.0",
    "@fontsource/fraunces": "^5.0.0",
    "@fontsource/public-sans": "^5.0.0"
  },
  "devDependencies": {
    "vitest": "^2.0.0"
  }
}
```

- [x] **Step 2: Write `astro.config.mjs`**

```js
import { defineConfig } from 'astro/config';

export default defineConfig({
  output: 'static',
});
```

- [x] **Step 3: Write `tsconfig.json`**

```json
{
  "extends": "astro/tsconfigs/base"
}
```

- [x] **Step 4: Write `.gitignore`**

```
node_modules/
dist/
.astro/
```

- [x] **Step 5: Write `src/styles/tokens.css`**

```css
:root {
  --color-bg: #F7F2EA;
  --color-bg-alt: #EFE7D8;
  --color-ink: #2A2119;
  --color-accent: #8B5A3C;
  --color-accent-secondary: #B5613C;
  --color-border: #DDD2BE;

  --font-heading: 'Fraunces', Georgia, serif;
  --font-body: 'Public Sans', -apple-system, sans-serif;

  --space-1: 0.5rem;
  --space-2: 1rem;
  --space-3: 1.5rem;
  --space-4: 2rem;
  --space-6: 4rem;
  --space-8: 6rem;

  --breakpoint-stack: 700px;
}

* { box-sizing: border-box; }

html, body {
  margin: 0;
  padding: 0;
  background: var(--color-bg);
  color: var(--color-ink);
  font-family: var(--font-body);
  line-height: 1.5;
}

h1, h2, h3 {
  font-family: var(--font-heading);
  font-weight: 500;
  line-height: 1.15;
  margin: 0 0 var(--space-2) 0;
}

a { color: var(--color-accent); }

:focus-visible {
  outline: 2px solid var(--color-accent);
  outline-offset: 2px;
}
```

- [x] **Step 6: Write a temporary minimal `src/pages/index.astro` to prove the build pipeline**

```astro
---
import '@fontsource/fraunces';
import '@fontsource/public-sans';
import '../styles/tokens.css';
---
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <title>Heartwood</title>
  </head>
  <body>
    <h1>Heartwood</h1>
    <p>Site scaffold — replaced in Task 4.</p>
  </body>
</html>
```

- [x] **Step 7: Install and build**

Run: `npm install && npm run build`
Expected: exits 0, creates `dist/index.html` containing `<h1>Heartwood</h1>`.

Verify: `grep -q "Heartwood" dist/index.html && echo OK`
Expected output: `OK`

- [x] **Step 8: Commit**

```bash
git add package.json astro.config.mjs tsconfig.json .gitignore src/styles/tokens.css src/pages/index.astro package-lock.json
git commit -m "chore: scaffold Astro project with design tokens and self-hosted fonts"
```

---

### Task 2: Shared layout, nav, footer, placeholder component

**Files:**
- Create: `src/layouts/BaseLayout.astro`
- Create: `src/components/Nav.astro`
- Create: `src/components/Footer.astro`
- Create: `src/components/PlaceholderBlock.astro`
- Modify: `src/pages/index.astro` (use `BaseLayout` temporarily, still replaced fully in Task 4)

**Interfaces:**
- Consumes: `tokens.css` variables from Task 1.
- Produces:
  - `BaseLayout.astro` — props `{ title: string }`, renders `<html>/<head>/<body>` with fonts + tokens imported, `<Nav />`, a `<slot />` for page content, `<Footer />`.
  - `Nav.astro` — no props, no slots.
  - `Footer.astro` — no props, no slots.
  - `PlaceholderBlock.astro` — props `{ label: string, note?: string }`, renders a dashed-border block. Later tasks (Landing, Download) use `<PlaceholderBlock label="..." note="..." />`.

- [x] **Step 1: Write `src/components/Nav.astro`**

```astro
<nav class="nav">
  <a class="nav__wordmark" href="/">Heartwood</a>
  <div class="nav__links">
    <a href="/pricing">Pricing</a>
    <a href="/about">About</a>
    <a href="/download">Download</a>
  </div>
</nav>

<style>
  .nav {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: var(--space-3) var(--space-4);
    border-bottom: 1px solid var(--color-border);
  }
  .nav__wordmark {
    font-family: var(--font-heading);
    font-size: 1.25rem;
    color: var(--color-ink);
    text-decoration: none;
  }
  .nav__links {
    display: flex;
    gap: var(--space-3);
  }
  .nav__links a {
    color: var(--color-ink);
    text-decoration: none;
  }
  .nav__links a:hover {
    color: var(--color-accent);
  }
  @media (max-width: 700px) {
    .nav {
      flex-direction: column;
      align-items: flex-start;
      gap: var(--space-2);
    }
    .nav__links {
      gap: var(--space-2);
      flex-wrap: wrap;
    }
  }
</style>
```

- [x] **Step 2: Write `src/components/Footer.astro`**

```astro
<footer class="footer">
  <p class="footer__wordmark">Heartwood</p>
  <p class="footer__promise">Local-first. No accounts, no telemetry, no cloud.</p>
  <p class="footer__copyright">&copy; 2026 Heartwood.</p>
</footer>

<style>
  .footer {
    padding: var(--space-6) var(--space-4);
    border-top: 1px solid var(--color-border);
    text-align: center;
    color: var(--color-ink);
  }
  .footer__wordmark {
    font-family: var(--font-heading);
    font-size: 1.1rem;
    margin: 0 0 var(--space-1) 0;
  }
  .footer__promise {
    margin: 0 0 var(--space-1) 0;
  }
  .footer__copyright {
    margin: 0;
    opacity: 0.7;
    font-size: 0.875rem;
  }
</style>
```

- [x] **Step 3: Write `src/components/PlaceholderBlock.astro`**

```astro
---
interface Props {
  label: string;
  note?: string;
}
const { label, note } = Astro.props as Props;
---
<div class="placeholder" role="note" aria-label={label}>
  <p class="placeholder__label">{label}</p>
  {note && <p class="placeholder__note">{note}</p>}
</div>

<style>
  .placeholder {
    border: 2px dashed var(--color-border);
    background: var(--color-bg-alt);
    border-radius: 4px;
    padding: var(--space-4);
    text-align: center;
    color: var(--color-ink);
  }
  .placeholder__label {
    font-weight: 600;
    margin: 0 0 var(--space-1) 0;
  }
  .placeholder__note {
    margin: 0;
    font-style: italic;
    opacity: 0.75;
    font-size: 0.9rem;
  }
</style>
```

- [x] **Step 4: Write `src/layouts/BaseLayout.astro`**

```astro
---
import '@fontsource/fraunces';
import '@fontsource/public-sans';
import '../styles/tokens.css';
import Nav from '../components/Nav.astro';
import Footer from '../components/Footer.astro';

interface Props {
  title: string;
}
const { title } = Astro.props as Props;
---
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>{title}</title>
  </head>
  <body>
    <Nav />
    <main>
      <slot />
    </main>
    <Footer />
  </body>
</html>
```

- [x] **Step 5: Wire the temporary index page through `BaseLayout` to verify composition**

Replace `src/pages/index.astro` contents:

```astro
---
import BaseLayout from '../layouts/BaseLayout.astro';
---
<BaseLayout title="Heartwood">
  <h1>Heartwood</h1>
  <p>Site scaffold — replaced in Task 4.</p>
</BaseLayout>
```

- [x] **Step 6: Build and verify nav/footer render**

Run: `npm run build`

Verify: `grep -q "Local-first. No accounts, no telemetry, no cloud." dist/index.html && grep -q "nav__wordmark" dist/index.html && echo OK`
Expected output: `OK`

- [x] **Step 7: Commit**

```bash
git add src/layouts/BaseLayout.astro src/components/Nav.astro src/components/Footer.astro src/components/PlaceholderBlock.astro src/pages/index.astro
git commit -m "feat: add shared layout, nav, footer, and placeholder component"
```

---

### Task 3: Greenhouse capture logic + interactive demo island

**Files:**
- Create: `src/lib/greenhouseCapture.js`
- Create: `tests/greenhouseCapture.test.js`
- Create: `src/components/GreenhouseDemo.astro`

**Interfaces:**
- Consumes: `tokens.css` variables from Task 1.
- Produces: `prepareCapture(raw: string): string | null` from `src/lib/greenhouseCapture.js` — exported as a named export, used by `GreenhouseDemo.astro`'s client script and by the test file. `GreenhouseDemo.astro` — no props, self-contained; Task 4 (Landing) consumes it as `<GreenhouseDemo />`.

- [x] **Step 1: Write the failing test**

```js
// tests/greenhouseCapture.test.js
import { describe, it, expect } from 'vitest';
import { prepareCapture } from '../src/lib/greenhouseCapture.js';

describe('prepareCapture', () => {
  it('trims surrounding whitespace', () => {
    expect(prepareCapture('  call mom back  ')).toBe('call mom back');
  });

  it('returns null for empty or whitespace-only input', () => {
    expect(prepareCapture('   ')).toBeNull();
    expect(prepareCapture('')).toBeNull();
  });

  it('truncates to 140 characters', () => {
    const long = 'a'.repeat(200);
    const result = prepareCapture(long);
    expect(result.length).toBe(140);
  });
});
```

- [x] **Step 2: Run test to verify it fails**

Run: `npx vitest run tests/greenhouseCapture.test.js`
Expected: FAIL — `Cannot find module '../src/lib/greenhouseCapture.js'`

- [x] **Step 3: Write minimal implementation**

```js
// src/lib/greenhouseCapture.js
export function prepareCapture(raw) {
  const trimmed = raw.trim();
  if (!trimmed) return null;
  return trimmed.length > 140 ? trimmed.slice(0, 140) : trimmed;
}
```

- [x] **Step 4: Run test to verify it passes**

Run: `npx vitest run tests/greenhouseCapture.test.js`
Expected: PASS (3 tests)

- [x] **Step 5: Write `src/components/GreenhouseDemo.astro`**

No `<form>` wrapper — without JavaScript, pressing Enter in a bare `<input>` does nothing, so the widget is inert but never broken. With JavaScript, it becomes interactive.

```astro
<div class="greenhouse-demo">
  <label class="greenhouse-demo__label" for="greenhouse-input">
    Try it — set a thought down
  </label>
  <input
    id="greenhouse-input"
    class="greenhouse-demo__input"
    type="text"
    placeholder="e.g. did I lock the back door?"
    autocomplete="off"
  />
  <ul class="greenhouse-demo__list" id="greenhouse-list" aria-live="polite"></ul>
</div>

<script>
  import { prepareCapture } from '../lib/greenhouseCapture.js';

  const input = document.getElementById('greenhouse-input');
  const list = document.getElementById('greenhouse-list');

  input?.addEventListener('keydown', (event) => {
    if (event.key !== 'Enter') return;
    const captured = prepareCapture(input.value);
    if (!captured) return;

    const item = document.createElement('li');
    item.textContent = captured;
    item.className = 'greenhouse-demo__item';
    list?.prepend(item);
    input.value = '';
  });
</script>

<style>
  .greenhouse-demo {
    background: var(--color-bg-alt);
    border-radius: 8px;
    padding: var(--space-3);
    max-width: 28rem;
  }
  .greenhouse-demo__label {
    display: block;
    font-size: 0.9rem;
    margin-bottom: var(--space-1);
  }
  .greenhouse-demo__input {
    width: 100%;
    padding: var(--space-2);
    font-size: 1rem;
    font-family: var(--font-body);
    border: 1px solid var(--color-border);
    border-radius: 4px;
    background: var(--color-bg);
    color: var(--color-ink);
  }
  .greenhouse-demo__list {
    list-style: none;
    margin: var(--space-2) 0 0 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    gap: var(--space-1);
  }
  .greenhouse-demo__item {
    padding: var(--space-1) var(--space-2);
    border-left: 3px solid var(--color-accent);
    background: var(--color-bg);
    animation: settle 0.3s ease-out;
  }
  @keyframes settle {
    from { opacity: 0; transform: translateY(-4px); }
    to { opacity: 1; transform: translateY(0); }
  }
</style>
```

- [x] **Step 6: Build to confirm the island compiles**

Run: `npm run build`
Expected: exits 0 (Astro bundles the component's `<script>` even though it's not yet used on a page).

- [x] **Step 7: Commit**

```bash
git add src/lib/greenhouseCapture.js tests/greenhouseCapture.test.js src/components/GreenhouseDemo.astro
git commit -m "feat: add Greenhouse capture logic and interactive demo island"
```

---

### Task 4: Landing page

**Files:**
- Modify: `src/pages/index.astro` (replace temporary scaffold content entirely)

**Interfaces:**
- Consumes: `BaseLayout` (Task 2), `GreenhouseDemo` (Task 3), `PlaceholderBlock` (Task 2).
- Produces: final Landing page — no other task depends on its internals.

- [x] **Step 1: Write the final `src/pages/index.astro`**

```astro
---
import BaseLayout from '../layouts/BaseLayout.astro';
import GreenhouseDemo from '../components/GreenhouseDemo.astro';
import PlaceholderBlock from '../components/PlaceholderBlock.astro';
---
<BaseLayout title="Heartwood — A focus timer for a mind that wanders">
  <section class="hero">
    <div class="hero__copy">
      <h1>A place to set your mind down.</h1>
      <p>
        Heartwood is a focus timer for macOS, Windows, and Linux. When a
        thought pulls at you mid-session, you capture it in the Greenhouse
        and keep working — nothing is lost, nothing has to be decided
        right now.
      </p>
    </div>
    <GreenhouseDemo />
  </section>

  <section class="recording">
    <PlaceholderBlock
      label="Real session recording goes here"
      note="A short screen recording of an actual Heartwood session will replace this block."
    />
  </section>

  <section class="local-first">
    <h2>Everything stays on your machine.</h2>
    <p>No accounts. No telemetry. No ads. No cloud. Heartwood runs locally and stores everything you write locally — full stop.</p>
  </section>

  <section class="features">
    <h2>What else is here</h2>
    <ul>
      <li><strong>Soundscapes</strong> — one included free, more with the full version.</li>
      <li><strong>Touch grass</strong> — a deliberate extended-break button, for when focus runs dry.</li>
      <li><strong>Markdown session notes</strong> — write plainly, format if you want to.</li>
      <li><strong>Versioned history</strong> — everything you've ever written, kept.</li>
    </ul>
  </section>

  <section class="cta">
    <a class="cta__button" href="/download">Download Heartwood</a>
    <a class="cta__link" href="/pricing">See pricing</a>
  </section>
</BaseLayout>

<style>
  .hero {
    display: flex;
    flex-wrap: wrap;
    gap: var(--space-4);
    align-items: flex-start;
    padding: var(--space-6) var(--space-4);
  }
  .hero__copy {
    flex: 1 1 22rem;
  }
  .hero h1 {
    font-size: 2.5rem;
  }
  .recording, .local-first, .features, .cta {
    padding: var(--space-4);
    max-width: 48rem;
    margin: 0 auto;
  }
  .local-first {
    text-align: center;
    padding-top: var(--space-6);
    padding-bottom: var(--space-6);
  }
  .features ul {
    list-style: none;
    padding: 0;
    display: flex;
    flex-direction: column;
    gap: var(--space-2);
  }
  .cta {
    display: flex;
    gap: var(--space-3);
    align-items: center;
    justify-content: center;
    padding-top: var(--space-6);
    padding-bottom: var(--space-8);
  }
  .cta__button {
    background: var(--color-accent);
    color: var(--color-bg);
    padding: var(--space-2) var(--space-4);
    border-radius: 4px;
    text-decoration: none;
    font-weight: 600;
  }
  .cta__link {
    color: var(--color-ink);
  }
  @media (max-width: 700px) {
    .hero { flex-direction: column; }
  }
</style>
```

- [x] **Step 2: Build and verify required content is present**

Run: `npm run build`

Verify:
```bash
grep -q "A place to set your mind down." dist/index.html \
  && grep -q "No accounts. No telemetry. No ads. No cloud." dist/index.html \
  && grep -q "Real session recording goes here" dist/index.html \
  && echo OK
```
Expected output: `OK`

Verify no banned terms leaked in:
```bash
grep -qi "sync" dist/index.html && echo FAIL || echo OK
grep -qi "mobile app" dist/index.html && echo FAIL || echo OK
```
Expected output: `OK` for both.

- [x] **Step 3: Commit**

```bash
git add src/pages/index.astro
git commit -m "feat: build final Landing page"
```

---

### Task 5: Pricing page

**Files:**
- Create: `src/pages/pricing.astro`

**Interfaces:**
- Consumes: `BaseLayout` (Task 2).
- Produces: nothing consumed by later tasks.

- [x] **Step 1: Write `src/pages/pricing.astro`**

```astro
---
import BaseLayout from '../layouts/BaseLayout.astro';
---
<BaseLayout title="Pricing — Heartwood">
  <section class="pricing">
    <h1>Pricing</h1>

    <div class="plans">
      <article class="plan">
        <h2>Free</h2>
        <p class="plan__price">$0</p>
        <ul>
          <li>Timer</li>
          <li>Unlimited Greenhouse captures</li>
          <li>One soundscape</li>
        </ul>
        <p class="plan__note">No account required.</p>
      </article>

      <article class="plan plan--full">
        <h2>Full version</h2>
        <p class="plan__price">$19 one-time</p>
        <p class="plan__subnote">Early adopter price — rising to $29 at 1.0.</p>
        <ul>
          <li>All soundscapes</li>
          <li>Versioned history</li>
          <li>Markdown session notes</li>
          <li>Export</li>
          <li>Session analytics</li>
          <li>Unlimited devices you own</li>
        </ul>
      </article>
    </div>

    <p class="pricing__footnote">Both tiers are one-time — there's no subscription, ever.</p>
  </section>
</BaseLayout>

<style>
  .pricing {
    max-width: 48rem;
    margin: 0 auto;
    padding: var(--space-6) var(--space-4);
    text-align: center;
  }
  .plans {
    display: flex;
    flex-wrap: wrap;
    gap: var(--space-4);
    justify-content: center;
    margin-top: var(--space-4);
    text-align: left;
  }
  .plan {
    flex: 1 1 18rem;
    border: 1px solid var(--color-border);
    border-radius: 8px;
    padding: var(--space-4);
    background: var(--color-bg-alt);
  }
  .plan__price {
    font-size: 1.5rem;
    font-family: var(--font-heading);
    margin: 0 0 var(--space-1) 0;
  }
  .plan__subnote {
    font-size: 0.875rem;
    opacity: 0.8;
    margin: 0 0 var(--space-2) 0;
  }
  .plan__note {
    font-size: 0.875rem;
    opacity: 0.8;
  }
  .pricing__footnote {
    margin-top: var(--space-4);
    opacity: 0.8;
  }
</style>
```

- [x] **Step 2: Build and verify content**

Run: `npm run build`

Verify:
```bash
grep -q "\$19 one-time" dist/pricing/index.html \
  && grep -q "rising to \$29 at 1.0" dist/pricing/index.html \
  && grep -q "No account required." dist/pricing/index.html \
  && echo OK
grep -qi "sync" dist/pricing/index.html && echo FAIL || echo OK
grep -qi "mobile" dist/pricing/index.html && echo FAIL || echo OK
```
Expected output: `OK` for all four checks.

- [x] **Step 3: Commit**

```bash
git add src/pages/pricing.astro
git commit -m "feat: build Pricing page"
```

---

### Task 6: About page

**Files:**
- Create: `src/pages/about.astro`

**Interfaces:**
- Consumes: `BaseLayout` (Task 2).
- Produces: nothing consumed by later tasks.

- [x] **Step 1: Write `src/pages/about.astro`**

The mission statement must be reproduced verbatim.

```astro
---
import BaseLayout from '../layouts/BaseLayout.astro';
---
<BaseLayout title="About — Heartwood">
  <section class="mission">
    <blockquote>
      Attention doesn't move in a straight line, and Heartwood isn't built
      to fight that. When your mind wanders, you set the thought down
      instead of losing the fight against it — and nothing set down here
      is wasted. It becomes structure: quiet, load-bearing, holding up
      whatever comes next. Step away when focus runs dry. That's not
      empty time — it's water. What you've set down takes root in it.
    </blockquote>
  </section>

  <section class="metaphor">
    <h2>Heartwood</h2>
    <p>
      In a living tree, the oldest growth at the center eventually stops
      being active. It stops carrying water, stops growing — and becomes
      the heartwood: dense, still, and load-bearing. It's what holds the
      rest of the tree up.
    </p>
    <p>
      That's what happens to a thought you set down in the Greenhouse. It
      stops pulling at your attention. It doesn't disappear — it becomes
      part of the structure you're standing on.
    </p>
  </section>

  <section class="privacy">
    <h2>Why local-first</h2>
    <p>
      Heartwood doesn't have an account system, because it doesn't need
      one. There's no telemetry, no analytics phoning home, no cloud
      sync, no ads. Everything you type — every captured thought, every
      session note — stays on your machine, in files you can read without
      Heartwood at all.
    </p>
  </section>
</BaseLayout>

<style>
  .mission, .metaphor, .privacy {
    max-width: 42rem;
    margin: 0 auto;
    padding: var(--space-6) var(--space-4);
  }
  .mission blockquote {
    font-family: var(--font-heading);
    font-size: 1.5rem;
    line-height: 1.4;
    margin: 0;
    padding: 0;
    border: none;
  }
</style>
```

- [x] **Step 2: Build and verify the mission statement is present verbatim**

Run: `npm run build`

Verify:
```bash
grep -q "Attention doesn't move in a straight line" dist/about/index.html \
  && grep -q "What you've set down takes root in it." dist/about/index.html \
  && grep -q "heartwood" dist/about/index.html \
  && echo OK
```
Expected output: `OK`

- [x] **Step 3: Commit**

```bash
git add src/pages/about.astro
git commit -m "feat: build About page with verbatim mission statement and heartwood metaphor"
```

---

### Task 7: Download page

**Files:**
- Create: `src/pages/download.astro`

**Interfaces:**
- Consumes: `BaseLayout` (Task 2), `PlaceholderBlock` (Task 2).
- Produces: nothing consumed by later tasks.

- [x] **Step 1: Write `src/pages/download.astro`**

```astro
---
import BaseLayout from '../layouts/BaseLayout.astro';
import PlaceholderBlock from '../components/PlaceholderBlock.astro';
---
<BaseLayout title="Download — Heartwood">
  <section class="download">
    <h1>Download Heartwood</h1>
    <p>Local-first. No accounts, no telemetry, no cloud.</p>

    <div class="download__grid">
      <article class="download__card">
        <h2>macOS</h2>
        <a class="download__button" href="#" aria-disabled="true">Coming soon</a>
      </article>
      <article class="download__card">
        <h2>Windows</h2>
        <a class="download__button" href="#" aria-disabled="true">Coming soon</a>
      </article>
      <article class="download__card">
        <h2>Linux</h2>
        <a class="download__button" href="#" aria-disabled="true">Coming soon</a>
      </article>
    </div>

    <PlaceholderBlock
      label="System requirements go here"
      note="Minimum OS versions and hardware requirements will be listed once builds are finalized."
    />
  </section>
</BaseLayout>

<style>
  .download {
    max-width: 48rem;
    margin: 0 auto;
    padding: var(--space-6) var(--space-4);
    text-align: center;
  }
  .download__grid {
    display: flex;
    flex-wrap: wrap;
    gap: var(--space-3);
    justify-content: center;
    margin: var(--space-4) 0 var(--space-6) 0;
  }
  .download__card {
    flex: 1 1 12rem;
    border: 1px solid var(--color-border);
    border-radius: 8px;
    padding: var(--space-3);
    background: var(--color-bg-alt);
  }
  .download__button {
    display: inline-block;
    margin-top: var(--space-2);
    padding: var(--space-1) var(--space-3);
    border-radius: 4px;
    background: var(--color-border);
    color: var(--color-ink);
    text-decoration: none;
    cursor: default;
  }
</style>
```

- [x] **Step 2: Build and verify content**

Run: `npm run build`

Verify:
```bash
grep -q "macOS" dist/download/index.html \
  && grep -q "Windows" dist/download/index.html \
  && grep -q "Linux" dist/download/index.html \
  && grep -q "System requirements go here" dist/download/index.html \
  && echo OK
```
Expected output: `OK`

- [x] **Step 3: Commit**

```bash
git add src/pages/download.astro
git commit -m "feat: build Download page"
```

---

### Task 8: Responsive and accessibility pass

**Files:**
- Modify: `src/styles/tokens.css` (focus-visible already present from Task 1 — verify, extend if needed)
- Modify: `src/pages/pricing.astro` (stack plan cards below 700px — flex-wrap already handles this; add explicit single-column rule for clarity)
- Modify: `src/pages/download.astro` (stack cards below 700px)

**Interfaces:**
- Consumes: all components/pages from Tasks 1–7.
- Produces: nothing consumed by later tasks (final polish task).

- [x] **Step 1: Add explicit stack rules to `src/pages/pricing.astro`**

Add to the `<style>` block:

```css
  @media (max-width: 700px) {
    .plans { flex-direction: column; }
  }
```

- [x] **Step 2: Add explicit stack rules to `src/pages/download.astro`**

Add to the `<style>` block:

```css
  @media (max-width: 700px) {
    .download__grid { flex-direction: column; }
  }
```

- [x] **Step 3: Verify keyboard focus is visible on every interactive element**

Run: `npm run dev`, then in a browser tab through: Nav links → Greenhouse demo input → Landing CTA buttons → Pricing page (no interactive elements besides nav) → Download page's three (inert) links → Footer.

Expected: every focused element shows a visible outline (from the global `:focus-visible` rule in `tokens.css`). No element is focusable-but-invisible.

- [x] **Step 4: Verify JS-disabled fallback**

Run: `npm run build && npm run preview`, then load the site with JavaScript disabled in the browser (e.g. Chrome DevTools → Settings → Debugger → Disable JavaScript).

Expected: all four pages render full content and are navigable; the Greenhouse demo input is visible but inert (no crash, no visual breakage, per Task 3 Step 5's no-`<form>` design).

- [x] **Step 5: Commit**

```bash
git add src/pages/pricing.astro src/pages/download.astro
git commit -m "fix: stack pricing and download cards on narrow viewports"
```

---

### Task 9: Full-site constraint verification

**Files:**
- Create: `scripts/verify-constraints.sh`

**Interfaces:**
- Consumes: the built `dist/` output from all previous tasks.
- Produces: nothing consumed by later tasks (final gate).

- [x] **Step 1: Write `scripts/verify-constraints.sh`**

```bash
#!/usr/bin/env bash
set -euo pipefail

npm run build

FAIL=0

check_absent() {
  if grep -riq "$1" dist/ ; then
    echo "FAIL: found banned term '$1'"
    FAIL=1
  fi
}

check_present() {
  if ! grep -riq "$1" "$2" ; then
    echo "FAIL: missing required content '$1' in $2"
    FAIL=1
  fi
}

# Banned content: no sync/mobile mentions, no Inter font, no fake metrics language
check_absent "sync"
check_absent "mobile app"
check_absent "font-family: 'Inter'"
check_absent "10x"
check_absent "testimonial"

# Required content per page
check_present "No accounts. No telemetry. No ads. No cloud." dist/index.html
check_present "Real session recording goes here" dist/index.html
check_present "\\\$19 one-time" dist/pricing/index.html
check_present "No account required." dist/pricing/index.html
check_present "Attention doesn't move in a straight line" dist/about/index.html
check_present "System requirements go here" dist/download/index.html
check_present "Local-first. No accounts, no telemetry, no cloud." dist/index.html

if [ "$FAIL" -eq 1 ]; then
  echo "Constraint verification FAILED"
  exit 1
fi

echo "Constraint verification PASSED"
```

- [x] **Step 2: Make it executable and run it**

Run: `chmod +x scripts/verify-constraints.sh && ./scripts/verify-constraints.sh`
Expected output: `Constraint verification PASSED`

- [x] **Step 3: Run the unit test suite one more time as part of the same gate**

Run: `npm run test`
Expected: 3 passing tests (from Task 3).

- [x] **Step 4: Commit**

```bash
git add scripts/verify-constraints.sh
git commit -m "test: add scripted constraint verification gate for the full site"
```

---

## Self-Review Notes

- **Spec coverage:** visual system → Task 1; architecture/shared chrome → Task 2; Greenhouse interactive demo → Task 3; Landing/Pricing/About/Download → Tasks 4–7; responsive/accessibility cross-cutting section → Task 8; placeholder handling → embedded in Tasks 2, 4, 7; testing/QA approach → Task 8 (manual) + Task 9 (scripted). All spec sections have a task.
- **Placeholder scan:** no TBD/TODO steps; all code blocks are complete and runnable as written.
- **Type/interface consistency:** `prepareCapture` name and signature match between Task 3's implementation, its test, and its use in `GreenhouseDemo.astro`'s script. `PlaceholderBlock` props (`label`, `note?`) match across Task 2's definition and its Task 4/Task 7 usages. `BaseLayout` prop (`title`) matches across all page tasks.
