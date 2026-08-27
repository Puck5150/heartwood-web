---
name: Heartwood
description: A quiet, warm, local-first focus timer's marketing site
colors:
  bg: "#F5EEEA"
  bg-alt: "#F8F2EE"
  surface: "#FFFDFB"
  flow-surface: "#F7E7DA"
  break-surface: "#E7F0E8"
  ink: "#342821"
  ink-muted: "#6C5D54"
  accent: "#8A4B19"
  accent-secondary: "#356345"
  border: "#D8C9C0"
  ring: "#CBB6A3"
typography:
  display:
    fontFamily: "Young Serif, Georgia, Times New Roman, serif"
    fontSize: "clamp(2.75rem, 1.75rem + 4vw, 4.5rem)"
    fontWeight: 400
    lineHeight: 1.15
    letterSpacing: "-0.02em"
  body:
    fontFamily: "-apple-system, Segoe UI, system-ui, Roboto, sans-serif"
    fontSize: "1rem"
    fontWeight: 400
    lineHeight: 1.6
    letterSpacing: "normal"
  label:
    fontFamily: "-apple-system, Segoe UI, system-ui, Roboto, sans-serif"
    fontSize: "0.9rem"
    fontWeight: 400
    lineHeight: 1.6
    letterSpacing: "normal"
rounded:
  xs: "3px"
  sm: "4px"
  md: "6px"
  lg: "8px"
  pill: "100px"
spacing:
  1: "0.5rem"
  2: "1rem"
  3: "1.5rem"
  4: "2rem"
  5: "2.5rem"
  6: "4rem"
  7: "5rem"
  8: "6rem"
components:
  button-primary:
    backgroundColor: "{colors.bg}"
    textColor: "{colors.accent}"
    rounded: "{rounded.sm}"
    padding: "16px 32px"
  button-primary-cta-band:
    backgroundColor: "{colors.accent}"
    textColor: "{colors.bg}"
  input-text:
    backgroundColor: "{colors.bg}"
    textColor: "{colors.ink}"
    rounded: "{rounded.sm}"
    padding: "16px"
  nav-link:
    textColor: "{colors.ink}"
    typography: "{typography.body}"
---

# Design System: Heartwood

## Overview

**Creative North Star: "The Borrowed Hearth"**

This site does not invent a brand — it borrows one, deliberately. `heartwood-app` (the desktop product this site sells) already has a real, tested visual identity: seven named theme families with self-hosted type and semantic color tokens. The marketing site exists to make visitors trust the app, so it wears the app's actual Cozy/Light theme rather than running a separate design exercise next to it. The two should feel like the same object seen from two rooms.

Warm paper, walnut-brown ink, one self-hosted display serif carried over byte-for-byte from the app's own font file. No gradients, no stock imagery, no icon rows. Whitespace and typography do almost all of the work; the one recurring motif (concentric growth rings) is spent exactly once, on the About page, where the "heartwood" metaphor is the actual subject.

**Key Characteristics:**
- Sourced, not invented: every hex value traces to `heartwood-app/src/app.css`'s Cozy/Light block.
- Restrained on background/surface, Committed on two whole-section color washes carrying product meaning (warm = focus, green = rest/trust).
- One motif, spent once, at full size, where the words are literally about it.
- Zero third-party font network requests — the display face is self-hosted, the body face is the OS's own system stack.

## Colors

Warm neutrals carry the page; the two accents are used sparingly and the two surface tints are used as whole-section washes, not text.

### Primary
- **Walnut** (`#8A4B19`): the site's one true accent — links, focus rings, the CTA band's fill, nav active/hover state. Same hex as the app's `--flow-accent` and its "orange" timer accent.

### Secondary
- **Cedar Green** (`#356345`): used once as the "Early adopter" pricing badge. Same hex as the app's `--break-accent` (its rest/trust state color) — a deliberate, sparing echo, not a second brand color competing with walnut.

### Neutral
- **Paper** (`#F5EEEA`): page background.
- **Warm Mist** (`#F8F2EE`): the subtlest surface tint (currently unused as a section fill, reserved).
- **Bright Paper** (`#FFFDFB`): card surfaces (pricing, download).
- **Kindled Surface** (`#F7E7DA`): the Greenhouse demo widget and the highlighted pricing tier — the app's "focus/on-task" surface tint.
- **Mossed Surface** (`#E7F0E8`): the local-first trust section and the About metaphor block — the app's "rest/safety" surface tint.
- **Ink** (`#342821`): body text.
- **Faded Ink** (`#6C5D54`): secondary/muted text.
- **Border** (`#D8C9C0`): hairlines, card edges, input borders.
- **Ring Tint** (`#CBB6A3`): the tree-rings motif's fainter strokes only — not used anywhere else.

### Named Rules
**The Two-Surface Rule.** Only two background washes ever fill a whole section — Kindled (warm) for focus/on-task moments, Mossed (green) for rest/trust moments. A third wash color would dilute both into decoration.

## Typography

**Display Font:** Young Serif (with Georgia, Times New Roman fallback)
**Body Font:** -apple-system, Segoe UI, system-ui, Roboto, sans-serif (the OS's own stack — no web font)

**Character:** Young Serif is warm and slightly bookish without being twee; it ships one weight only, so every heading is set at 400 with `font-synthesis: none` rather than faux-bolded. The system sans stays invisible on purpose — it's the same choice the app itself makes, and it costs zero network weight, which reads as more local-first, not less.

### Hierarchy
- **Display** (400, `clamp(2.75rem, 1.75rem + 4vw, 4.5rem)`, 1.15): the Landing hero h1 only.
- **Headline** (400, `clamp(2rem, 1.5rem + 2vw, 2.75rem)`, 1.15): page h1s (Pricing, About's sr-only h1, Download).
- **Title** (400, `clamp(1.375rem, 1.2rem + 0.7vw, 1.625rem)`, 1.15): section h2s.
- **Body** (400, 1rem, 1.6): all copy; measure capped per-section (42–60ch) rather than page-wide.
- **Label** (400, 0.9rem, 1.6): small supporting text — the Greenhouse demo's field label, pricing subnotes.
- **Mission quote** (400, `clamp(1.375rem, 1rem + 1.5vw, 1.875rem)`, 1.45): the one deliberate display-serif oversize outside the hero — the About page's verbatim mission statement.

### Named Rules
**The One-Weight Rule.** Young Serif has no bold. Emphasis in headings comes from size and color, never synthesized weight.

**The Component-Size Exception.** A handful of component-specific sizes sit intentionally between the five named ramp steps rather than snapping to them: the nav wordmark (1.375rem), the footer wordmark (1.1rem, smaller — a footer signs off, it doesn't announce), the pricing plan price (1.75rem), pricing/download card titles (1.25–1.375rem), and the About mission blockquote's own fluid range (`clamp(1.375rem, 1rem + 1.5vw, 1.875rem)`, distinct from Title). These predate this design pass and are deliberate per-component choices, not drift — pulling them onto the five-step ramp would flatten several things that are supposed to read at different weights in different contexts.

## Layout

Four thin pages sharing one `BaseLayout`; each section is either full-bleed (color washes, CTA band, nav, footer) or capped at a content max-width (44–48rem) centered on the page. Spacing rhythm runs on an 8-step scale (`0.5rem` to `6rem`); section padding is generous (`--space-6`–`--space-8`) while in-content gaps stay tight (`--space-1`–`--space-3`). Single-column stack below 700px — the nav collapses to wordmark-then-links, the hero drops its side-by-side demo, card grids go one-per-row.

## Elevation & Depth

Two shadow tokens, both flat-by-default with an offset and soft blur — nothing sits raised unless it's a card or an elevated pricing tier:

### Shadow Vocabulary
- **Card** (`box-shadow: 0 8px 24px -8px rgba(52, 40, 33, 0.15)`): pricing cards, download cards — ink-tinted, not black.
- **Lifted** (`box-shadow: 0 20px 40px -20px rgba(138, 75, 25, 0.35), 0 4px 10px -4px rgba(138, 75, 25, 0.18)`): the highlighted "Full version" pricing tier only — accent-tinted, one step further than Card.

### Named Rules
**The One Elevation Step Rule.** Nothing on the site uses more than two shadow strengths. A third would turn "the recommended plan" into "everything is trying to float."

## Shapes

Soft, small radii throughout (3–8px) — never sharp, never pill-shaped except the one deliberately pill-shaped "Coming soon" / badge chips, which read as tags rather than buttons. The Greenhouse demo's captured-item rows use the smallest step (3px) — visually distinct from the demo widget's own 8px container without competing with it. Cards and inputs share a 1px hairline border in Border (`#D8C9C0`); the CTA band and color-wash sections have no border at all, just a flat color-to-color transition.

## Components

### Buttons
- **Shape:** 4px radius (`{rounded.sm}`).
- **Primary (in-context, e.g. nav):** walnut text on paper, no fill.
- **Primary (CTA band):** inverted — paper fill, walnut text; `transform: translateY(-2px)` on hover, no color change.
- **Focus:** 2px solid outline in Walnut everywhere except inside the CTA band, where it's scoped to Paper so the ring stays visible against the walnut fill.

### Cards / Containers
- **Corner Style:** 6px radius (`{rounded.md}`).
- **Background:** Bright Paper by default; Kindled Surface for the one highlighted pricing tier.
- **Shadow Strategy:** Card by default, Lifted for the highlighted tier (see Elevation & Depth).
- **Border:** 1px Border, Walnut for the highlighted tier.

### Inputs / Fields
- **Style:** 4px radius, 1px Border stroke, Paper background sitting on top of whatever surface wash contains it.
- **Focus:** 2px solid Walnut outline, same as buttons and links — one focus treatment site-wide, no variants.
- **Overflow:** `text-overflow: ellipsis` on the Greenhouse demo input — a real placeholder sentence must degrade gracefully at narrow widths rather than hard-clip mid-word.

### Navigation
- **Style:** wordmark left (Young Serif), three text links right, no icons, no login (nothing to log into).
- **Default:** Ink text, no underline.
- **Hover / Active:** Walnut text plus a 2px underline that grows from the left (`transform: scaleX()`), the active page's underline held permanently via `aria-current="page"` rather than a separate visual language.
- **Mobile (<700px):** stacks to wordmark, then links wrap below; nav stays sticky at the top regardless of breakpoint.

### Tree Rings (signature component)
Six concentric circles, hand-authored inline SVG, alternating Walnut and Ring Tint strokes at low opacity (0.2–0.55). Appears exactly once, centered behind the About page's mission-statement blockquote — never repeated as a page-wide pattern. A two-layer `radial-gradient` ring-and-dot glyph echoes the same idea in miniature as the list-bullet mark (Landing features, Greenhouse captured items).

## Do's and Don'ts

### Do:
- **Do** source every color and font from `heartwood-app/src/app.css` and its font asset before inventing anything new — this site's whole visual authority is "we are the same product," not independent taste.
- **Do** use Kindled Surface for focus/on-task content and Mossed Surface for rest/trust content — the mapping is semantic, not decorative rotation.
- **Do** keep Young Serif to headings and the mission quote only; body copy stays on the system sans stack.
- **Do** give every interactive element the same 2px solid Walnut focus outline (scoped to Paper only inside the walnut CTA band).

### Don't:
- **Don't** add a third whole-section color wash beyond Kindled and Mossed.
- **Don't** synthesize bold or italic on Young Serif — it has one weight; use size and color for emphasis instead.
- **Don't** spend the tree-rings motif more than once per page, or on any page besides About.
- **Don't** add a web font, an icon font, or a third-party font/analytics network request — self-hosted or system stack only.
