# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Stack

Astro (static output), vanilla JS (no UI framework), vitest for the one unit-testable module. Existing codebase; not a greenfield choice.

## Users

Two overlapping audiences: people with ADHD and adjacent attention profiles, and privacy-conscious people who prefer local-first software over cloud/subscription tools. Both are allergic to hustle-culture productivity marketing and to being sold to.

## Product Purpose

Heartwood is a local-first, Pomodoro-style focus timer for macOS, Windows, and Linux. It exists so a wandering mind mid-session has somewhere to go that isn't "fight it" or "lose the session." Success is a visitor understanding the Greenhouse mechanic and the local-first promise within seconds of landing, without feeling marketed at.

## Positioning

The distinguishing mechanism is the **Greenhouse**: mid-session, an intrusive thought gets typed and set down (not dismissed, not acted on) without breaking focus. This is a concrete interaction, not an abstract "mindfulness" claim — the Landing page demonstrates it live. The second pillar: everything stays on the user's machine — no accounts, no telemetry, no ads, no cloud. This is a core promise, not a footnote or a checkbox in a feature list.

## Operating Context

Four pages only: Landing, Pricing, About, Download. No blog, no changelog, no backend, no CMS. The desktop app (`heartwood-app`, sibling repo) is the product being marketed; this site is static and does not talk to it at runtime.

## Capabilities and Constraints

- Free tier: timer, unlimited Greenhouse captures, one soundscape, no account required.
- Paid tier: $19 one-time (early adopter price, rising to $29 at 1.0) — all soundscapes, versioned history, markdown notes, export, session analytics, unlimited devices you own. One-time, not a subscription.
- No sync, no mobile app — neither exists. Never mention either.
- Must not frame productivity as moral worth, must not imply the app treats or fixes ADHD, must avoid urgency language, countdown timers, artificial scarcity, or "10x your output" framing.
- Invent nothing: no fake testimonials, download counts, user quotes, or fabricated screenshots. Real assets (screen recording, OS download links) get clearly marked placeholders, styled honestly as placeholders — never dressed up as finished content.
- Site must remain fully readable and navigable with JavaScript disabled; the Greenhouse demo island is progressive enhancement only.
- Self-hosted fonts only — no third-party font/analytics network requests, consistent with the no-telemetry promise.

## Brand Commitments

- Name: Heartwood. Wordmark is type-only (no icon/logomark for v1), set in the display serif.
- Visual identity is sourced from the sibling `heartwood-app` desktop app's real design-token system, not invented independently for the site. The app ships 7 named theme families (Sunlit, Cozy, Quiet Natural, Coastal Air, Night Walk, Moon Garden, Graphite), each with light/dark variants and a shared semantic token set (`--app-background`, `--surface`, `--text`, `--text-muted`, `--border`, `--flow-accent`, `--break-accent`, `--danger`, etc.) plus a self-hosted display font, **Young Serif** (not Fraunces — the site's prior font choice predates this discovery and is being retired).
- Decision (user-confirmed): the site commits to one fixed theme rather than a live switcher — **Cozy**, light mode (`#f5eeea` background, `#8a4b19` walnut-brown accent) — as its permanent identity. This is the closest existing app theme to the original marketing spec's "warm paper + heartwood brown" direction, so it reads as a refinement of the site's original intent rather than a swap.
- Tone: quiet, warm, a little wooded. Restraint over polish.
- Visual defaults to avoid: purple gradients, Inter typeface, nested card soup, three-icon hero rows, stock photography, wood-grain skeuomorphism, decorative icon rows.
- Recurring motif (from original spec, still binding): concentric tree-ring / growth-ring line work, used sparingly as a section divider or background accent — not decorative wallpaper.

## Evidence on Hand

- Mission statement (About page, verbatim, do not paraphrase): "Attention doesn't move in a straight line, and Heartwood isn't built to fight that. When your mind wanders, you set the thought down instead of losing the fight against it — and nothing set down here is wasted. It becomes structure: quiet, load-bearing, holding up whatever comes next. Step away when focus runs dry. That's not empty time — it's water. What you've set down takes root in it."
- No real screen recording, no real OS download links, no testimonials, no usage stats, no press exist yet — all remain honest placeholders.
- `heartwood-app/src/app.css` is the source of truth for all real color tokens and the Young Serif font file; treat it as evidence, not the site's own `tokens.css` (which currently holds hand-invented values predating this discovery).

## Product Principles

1. The Greenhouse mechanic is shown, not described — a real interactive demo beats a screenshot or a feature bullet every time.
2. Local-first is a headline claim, stated plainly on its own line — never buried in body copy or reduced to a footnote.
3. Never invent proof. A clearly labeled placeholder is always preferable to a fabricated testimonial, screenshot, or metric.
4. Visual identity is inherited from the real app, not designed in isolation — the site and the app must feel like the same product.
5. Restraint over polish: one motif (tree rings), used meaningfully and sparingly, beats a decorated page.

## Accessibility & Inclusion

Single-column stack below ~700px. Real visible focus states on every interactive element (nav links, CTA buttons, Greenhouse demo input). Semantic heading structure, one h1 per page. Full keyboard navigability. Site must remain usable with JavaScript disabled.
