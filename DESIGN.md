# Design

<!-- impeccable:design-schema 1 -->

## World

Cozy/Light — one of `heartwood-app`'s seven real theme families (`src/app.css`), adopted verbatim rather than invented for the site. This is a **sourced identity, not an original one**: the marketing site exists to make people trust the app, so it borrows the app's actual visual language rather than running its own brand exercise. See `PRODUCT.md`'s Brand Commitments for the full rationale and the fixed-theme-vs-switcher decision (fixed, user-confirmed).

Warm paper, walnut-brown accent, a self-hosted display serif the app itself ships. No gradients. Flat color, generous whitespace, one motif (concentric growth rings) used exactly once.

## Tokens

Defined in `src/styles/tokens.css`, copied from `heartwood-app/src/app.css`'s `[data-theme='cozy'][data-appearance='light']` block:

| Token | Value | Source |
|---|---|---|
| `--color-bg` | `#F5EEEA` | app `--app-background` |
| `--color-bg-alt` | `#F8F2EE` | app `--surface-secondary` |
| `--color-surface` | `#FFFDFB` | app `--surface` |
| `--color-flow-surface` | `#F7E7DA` | app `--flow-surface` (focus/on-task state) |
| `--color-break-surface` | `#E7F0E8` | app `--break-surface` (rest/safety state) |
| `--color-ink` | `#342821` | app `--text` |
| `--color-ink-muted` | `#6C5D54` | app `--text-muted` |
| `--color-accent` | `#8A4B19` | app `--flow-accent` / `--focus-ring` / timer-accent "orange" |
| `--color-accent-secondary` | `#356345` | app `--break-accent` |
| `--color-border` | `#D8C9C0` | app `--border` |
| `--color-ring` | `#CBB6A3` | tinted between border and accent, for the tree-rings motif only |

`--shadow-lifted` and `--shadow-card` are the site's own additions (app has no card-shadow token at this fidelity); their rgba matches `--color-accent` and `--color-ink` respectively rather than an invented hue.

## Type

- **Display** (`--font-heading`): `'Young Serif', Georgia, 'Times New Roman', serif` — self-hosted from `heartwood-app/src/assets/fonts/young-serif-400.woff2` (copied into `public/fonts/`), same `@font-face` and `unicode-range` as the app. Weight 400 only — the font ships no other weight, so headings are set at 400 rather than faux-bolded (`font-synthesis: none`, matching the app).
- **Body** (`--font-body`): `-apple-system, 'Segoe UI', system-ui, Roboto, sans-serif` — the app's own system stack, not a web font. Replaces the site's prior self-hosted Public Sans; system fonts cost zero network weight, which reads as *more* local-first, not less.

Fraunces and Public Sans (`@fontsource/*`) are fully removed from the project — no trace in `package.json`, `BaseLayout.astro`, or any component.

## Color strategy

Restrained on `bg`/`surface`, but Committed on two whole-section washes with product-specific meaning, not decorative rotation:

- `--color-flow-surface` (warm) marks focus/on-task moments — the Greenhouse demo widget, the highlighted pricing tier.
- `--color-break-surface` (green) marks rest/trust moments — the "everything stays on your machine" section, the About page's heartwood metaphor.
- The Landing CTA band is a full-bleed `--color-accent` fill (inverted paper button + underlined link) — the one place the accent owns the whole surface rather than an edge or a dot.

## Motif

`src/components/TreeRings.astro` — six concentric circles, hand-authored SVG, alternating `--color-accent`/`--color-ring` strokes at low opacity. Used once, behind the About page's mission-statement blockquote. The same idea appears in miniature as the list-bullet mark (Landing features, Greenhouse captured items) via a two-layer `radial-gradient` ring+dot — a quiet echo, not a repeat of the same asset.

## Motion

Progressive-enhancement scroll reveal (`.reveal` class, `tokens.css` + inline script in `BaseLayout.astro`): every reveal target is fully visible with no JS, no `prefers-reduced-motion`, or before hydration; only `html.js .reveal` ever hides content, and an `IntersectionObserver` (skipped under reduced motion) adds `.is-visible` once per element. Hero content is never gated — it's the first-viewport thesis and renders instantly. The Greenhouse demo's existing settle animation and the nav's underline-on-hover/active-page transition are unchanged.

## Navigation

`Nav.astro` reads `Astro.url.pathname` per page render and marks the current route `aria-current="page"`, styled with the same accent-underline the hover state uses — no separate "active" visual language.

## Components inherited unchanged

`GreenhouseDemo.astro`'s capture-and-settle interaction, `PlaceholderBlock.astro`'s dashed-border honesty marker, and the four-page structure are all pre-existing and out of scope for this pass — only their color/font inputs changed.

## Open / deferred

- No live theme switcher (user-confirmed: fixed Cozy theme only). The other six app theme families are not wired into this site.
- No View Transitions / client-side routing — evaluated and deliberately skipped to avoid SPA-navigation risk on a static four-page brochure site; full-page nav stays instant and predictable.
