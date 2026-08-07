# Heartwood Marketing Site — Design Spec

Date: 2026-08-07

## Product summary

Heartwood is a local-first, Pomodoro-style focus timer for macOS, Windows, and
Linux. Its distinguishing mechanic is the **Greenhouse**: a place to set down
an intrusive thought mid-session without breaking focus — type it, hit enter,
back to work. Other features: soundscapes, a "touch grass" extended-break
button, markdown session notes, and version-controlled history of everything
written. No accounts, no telemetry, no ads, no cloud — everything stays on
the user's machine. This is a core promise of the product, not a footnote.

Audience: people with ADHD and adjacent attention profiles, and
privacy-conscious people who prefer local-first software. Both groups are
allergic to hustle-culture productivity marketing and to being sold to. The
site must not frame productivity as moral worth, must not imply the app
treats or fixes ADHD, and must avoid urgency language, countdown timers, or
"10x your output" framing.

## Mission statement (verbatim, About page)

> Attention doesn't move in a straight line, and Heartwood isn't built to
> fight that. When your mind wanders, you set the thought down instead of
> losing the fight against it — and nothing set down here is wasted. It
> becomes structure: quiet, load-bearing, holding up whatever comes next.
> Step away when focus runs dry. That's not empty time — it's water. What
> you've set down takes root in it.

## Pages (four, no more)

1. **Landing** — what it is, Greenhouse mechanic front and center, calm and
   specific. Shows the product loop immediately via a real interactive
   demo, not an abstract description. Placeholder for a real screen
   recording.
2. **Pricing** — free tier stated plainly, no dark patterns.
3. **About** — mission statement (verbatim) + heartwood metaphor.
4. **Download** — macOS, Windows, Linux, placeholder links.

## Pricing

- **Free**: timer, unlimited Greenhouse captures, one soundscape. No
  account required.
- **$19 one-time** (early adopter price, rising to $29 at 1.0): all
  soundscapes, versioned history, markdown notes, export, session
  analytics, unlimited devices you own.
- No mention of sync or mobile anywhere — neither exists yet.

## Constraints

- Static site, no backend.
- Invent nothing: no fake testimonials, download counts, user quotes, or
  fabricated screenshots. Real assets get clearly marked placeholders.
- Avoid generic AI-SaaS visual defaults: purple gradients, Inter
  everywhere, nested card soup, three-icon hero rows.
- Tone: quiet, warm, a little wooded. Restraint over polish.

## Design tool

Visual implementation work (component styling, spacing, accessibility
polish, responsive behavior) will use the **Impeccable** skill during the
implementation phase.

---

## 1. Visual system

**Palette** — warm paper + heartwood brown. Anchor tokens (final values
locked during implementation, these are directional):

- Background (paper): warm bone, roughly `#F7F2EA`
- Alt section background: `#EFE7D8`
- Ink (text): warm near-black, roughly `#2A2119` (not pure black)
- Primary accent (heartwood): walnut-brown, roughly `#8B5A3C`
- Secondary accent (sparing use — links, small highlights): muted rust,
  roughly `#B5613C`

No gradients. Flat color, generous whitespace.

**Typography** — warm serif headlines + humanist sans body. Candidate
pairing: Fraunces (headlines — warm, slightly organic, bookish without
being twee) + Public Sans or Source Sans (body). Both self-hosted (no
Google Fonts CDN call at runtime) — consistent with the local-first,
privacy-respecting posture and avoids a render-blocking third-party
request. Explicitly not Inter.

**Texture/motif** — one recurring visual idea: concentric tree-ring /
growth-ring line work, used sparingly as a quiet section divider or
background accent. No stock photography, no wood-grain skeuomorphism, no
decorative icon rows. Restraint over polish: mostly typography + whitespace
+ one motif, used meaningfully rather than often.

**Wordmark** — type-only. "Heartwood" set in the headline serif. No
separate icon/logomark for v1.

## 2. Site architecture (Astro)

Static-generated site, Astro, no CMS, no client-side routing, no backend.

```
src/
  layouts/BaseLayout.astro       — shared <head>, nav, footer
  components/
    Nav.astro
    Footer.astro
    GreenhouseDemo.astro         — interactive capture-flow widget (client-side island, vanilla JS, no framework)
    PlaceholderBlock.astro       — reusable "real asset goes here" marker
  pages/
    index.astro                  — Landing
    pricing.astro
    about.astro
    download.astro
  styles/tokens.css              — color/type/spacing variables, single source of truth
public/
  fonts/                         — self-hosted Fraunces + body sans
```

One shared layout, four thin page files, one interactive island.

**Nav**: wordmark left; Pricing / About / Download right. No "Login" (no
accounts exist).

**Footer**: wordmark, one-line local-first promise ("Local-first. No
accounts, no telemetry, no cloud."), copyright, optional contact/GitHub
link (placeholder if none exists yet).

## 3. Page-by-page plan

### Landing

1. Nav (sticky, minimal).
2. Hero: short headline + one-line subhead stating plainly what the
   product is. Real copy drafted during implementation, reviewed against
   the tone constraints before shipping. Beside/below the hero: the live
   Greenhouse demo widget (see §7).
3. Screen-recording placeholder — clearly marked block (e.g. dashed
   border, explicit "real session recording goes here" label) directly
   after the interactive demo.
4. "What it is" — short section stating the local-first promise plainly,
   on its own line, not buried in body copy.
5. "Other features" — soundscapes, touch grass button, markdown notes,
   versioned history. Text-forward short list, not an icon-card grid.
6. CTA band — links to Download and Pricing. No urgency language, no
   countdown, no artificial scarcity.
7. Footer.

### Pricing

- Two plans side by side, plain cards. No "MOST POPULAR" badges, no
  fake-strikethrough discount pricing.
- Free tier and $19 tier as specified above, each listing its exact
  feature set.
- "No account required" stated plainly under the free tier.
- Early-adopter framing ($19 now, rising to $29 at 1.0) stated plainly,
  not urgency-framed (no countdown, no "only X left").
- Short clarifying line: one-time purchase, not a subscription; owned
  forever on the OS it's purchased for.
- No mention of sync or mobile.

### About

- Mission statement, verbatim, set large in the headline serif — the
  visual centerpiece of the page.
- Heartwood metaphor section: a tree's oldest growth stops being
  metabolically active and becomes the structure holding the rest of the
  tree up — the parallel to a captured thought. This is where the
  tree-ring motif appears, once, meaningfully.
- Short paragraph reinforcing the no-accounts/no-telemetry/no-cloud
  promise — About is where a privacy-conscious visitor goes to dig
  deeper.

### Download

- Three OS options (macOS, Windows, Linux), each a clearly labeled
  placeholder ("Download for macOS — link coming soon" or a visibly
  disabled state). Honest about being a placeholder, not styled to look
  broken.
- Brief system-requirements placeholder note.
- Repeat of the local-first promise line.

## 4. Greenhouse demo widget

A small Astro island (vanilla JS, no framework) on the Landing page: a text
input plus Enter. On submit, the typed thought slides out of the input and
settles into a small, calm list/visual below it (e.g. a quiet fade-in, or a
root-like line growing) — no fake "processing" delay, no animation that
implies AI/cloud work happening. This is a genuine small interactive demo
of the real mechanic, not a fabricated screenshot, so it satisfies "invent
nothing" while still showing the loop immediately per the landing-page
requirement. Deliberately minimal — a few seconds of interaction, not a
full app simulation.

## 5. Placeholder handling

All not-yet-real assets (screen recording, OS download links) use the
shared `PlaceholderBlock` component: visually distinct (e.g. dashed
border, muted label), with alt/label text stating exactly what real asset
will replace it. No placeholder is styled to look like finished content.

## 6. Cross-cutting: responsive & accessibility

- Single-column stack below ~700px; nav collapses to wordmark + simple
  menu.
- Real visible focus states on all interactive elements (nav links, CTA
  buttons, the Greenhouse demo input).
- Semantic heading structure (one h1 per page, logical nesting).
- Page content and navigation fully readable/usable with JavaScript
  disabled; the Greenhouse demo island is progressive enhancement only —
  its absence shouldn't break the page.
- Self-hosted fonts, no third-party font/analytics requests — consistent
  with "no telemetry."

## 7. Testing / QA approach

- Manual responsive check at common breakpoints (mobile ~375px, tablet
  ~768px, desktop ~1280px+).
- Manual keyboard-only pass (tab through nav, CTA, Greenhouse demo).
- Lighthouse/axe pass for basic accessibility and performance sanity
  (static site, should score well by default).
- Visual QA against the constraints list above (no gradients, no Inter,
  no invented content) before each page is considered done.

## Out of scope (explicitly not building)

- Accounts, auth, or any backend.
- Sync or mobile — not mentioned anywhere on the site.
- Blog, changelog, or any page beyond the four listed.
- Real testimonials, download counters, or usage stats (none exist yet).
