# Cotton Velvet Slipper Product Detail Design

## Product goal and audience
Present one custom cotton velvet / plush slipper style to overseas retailers, lifestyle brands, hospitality buyers, gift companies, and private-label programs. The page should make the product feel tactile while clearly explaining what can be customized and how a buyer starts an inquiry.

## Visual direction
Tactile Industrial Comfort: warm cream backgrounds, deep pine navigation and conversion surfaces, soft cocoa accents sampled from the supplied product artwork, and a measured technical grid. The page keeps the existing goodshoe MFG language rather than introducing a new brand system.

## Reference Sources
- Existing project visual language: `goodshoe-b2b/assets/css/style.css`
- Existing brand/navigation patterns: `goodshoe-b2b/index.html` and `goodshoe-b2b/wholesale.html`
- Canvas baseline references requested by the site-builder contract: `vendor/open-design/adapter/STATIC_POLICY.md`, `vendor/open-design/upstream/design-systems/industrial-heritage/DESIGN.md`, `vendor/open-design/upstream/design-systems/industrial-heritage/tokens.css`, `vendor/open-design/upstream/craft/anti-ai-slop.md`, `vendor/open-design/upstream/craft/typography-b2b.md`

## Vendor grounding
The referenced Open Design pack was not present in the workspace, so implementation uses the existing goodshoe MFG design system as the grounded baseline. Intentional deviations: the product page adds a cocoa-brown accent and tall image-led detail blocks to echo the supplied product artwork; it keeps the existing cream/pine/coral tokens for brand continuity.

## Tokens
- Background: existing `--c-cream`, `--c-paper`, `--c-cream-deep`
- Primary: existing `--c-pine`
- Action: existing `--c-coral`
- Product accent: `#9c470c` cocoa brown
- Text: existing `--c-ink`, `--c-ink-soft`, `--c-muted`
- Radius: existing `--rad`, `--rad-lg`, `--rad-pill`
- Layout: existing `.container` max width and responsive breakpoints
- Typography: existing `--f-display`, `--f-body`, `--f-mono`; no external font additions

## Component inventory
- Product detail hero with image and inquiry actions
- Product fact rail for use case, material, sole, and private-label options
- Feature specification cards
- Customization gallery and flow
- Material / construction detail blocks
- Factory and fulfillment gallery
- Inquiry CTA, sticky quote action, and WhatsApp floating action

## Page structure and responsive rules
1. Existing announcement and navigation.
2. Hero: title, buyer-facing value proposition, CTA buttons, and supplied hero artwork.
3. Product facts: material, plush warmth, anti-slip sole, and customization scope.
4. Comfort / construction: supplied lining, warmth, sole, and layered construction visuals.
5. Customization hub: supplied ODM/OEM, fabric, logo/pattern, and theme visuals.
6. Process: supplied customization workflow plus concise buyer steps.
7. Factory-to-door: supplied factory, packaging, and logistics visuals.
8. Closing inquiry CTA and existing footer.

Desktop uses a two-column hero and editorial detail grid. At 880px and below, all grids stack; galleries become a single-column flow; CTAs remain full-width or wrap without horizontal overflow.

## Interaction and motion
Use existing `.reveal` IntersectionObserver behavior, hover lift on detail cards, native `<details>` for the FAQ, and no cart, checkout, payment, or artificial urgency. All conversion actions go to `quote.html` or WhatsApp.

## Image Manifest
All 15 images are user-provided and copied to `assets/images/cotton-velvet-slipper/`. Each is used exactly once on the page.

| Local path | Source | Usage |
|---|---|---|
| `assets/images/cotton-velvet-slipper/cotton-velvet-01.jpg` | user-provided | Hero product overview |
| `assets/images/cotton-velvet-slipper/cotton-velvet-02.jpg` | user-provided | ODM/OEM customization example |
| `assets/images/cotton-velvet-slipper/cotton-velvet-03.jpg` | user-provided | Fabric options |
| `assets/images/cotton-velvet-slipper/cotton-velvet-04.jpg` | user-provided | Pattern and logo themes |
| `assets/images/cotton-velvet-slipper/cotton-velvet-05.jpg` | user-provided | Animal and seasonal themes |
| `assets/images/cotton-velvet-slipper/cotton-velvet-06.jpg` | user-provided | Cotton velvet upper / comfort feature |
| `assets/images/cotton-velvet-slipper/cotton-velvet-07.jpg` | user-provided | Plush lining and warmth |
| `assets/images/cotton-velvet-slipper/cotton-velvet-08.jpg` | user-provided | Warm-air layer story |
| `assets/images/cotton-velvet-slipper/cotton-velvet-09.jpg` | user-provided | Anti-slip sole |
| `assets/images/cotton-velvet-slipper/cotton-velvet-10.jpg` | user-provided | Layered material construction |
| `assets/images/cotton-velvet-slipper/cotton-velvet-11.jpg` | user-provided | Customization process |
| `assets/images/cotton-velvet-slipper/cotton-velvet-12.jpg` | user-provided | Hangers, labels, and outer-box support |
| `assets/images/cotton-velvet-slipper/cotton-velvet-13.jpg` | user-provided | Factory display |
| `assets/images/cotton-velvet-slipper/cotton-velvet-14.jpg` | user-provided | Packaging and cargo transport |
| `assets/images/cotton-velvet-slipper/cotton-velvet-15.jpg` | user-provided | Professional packaging and cooperation close |
