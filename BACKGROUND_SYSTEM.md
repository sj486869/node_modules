# Global Background Color System - PropFirmFusion

## Overview

A comprehensive global background color system has been applied across the entire PropFirmFusion website. The system uses a consistent **black-to-gold gradient** that flows across all pages, routes, and components.

## Color Palette

The system uses the following hex color values exclusively:

| Color Name | Hex Value | Usage |
|-----------|-----------|-------|
| Black Base | `#000000` | Background foundation |
| Warm Transition | `#1A1208` | Gradient midpoint (warm brown) |
| Gold Glow Zone | `#805A21` | Gradient right edge (golden) |
| Spotlight Glow | `#D49A38` | Radial gradient accent |
| Primary Gold Accent | `#F2C243` | Text/UI accents |
| Deep Gold Shadow | `#B8861E` | Depth and contrast |
| Gold Highlight | `#FFD778` | Bright highlights |

## How It Works

### CSS Variables (globals.css)

All colors are defined as CSS custom properties in `:root`:

```css
--gold-left: #000000;       /* Black */
--gold-mid: #1A1208;        /* Warm brown */
--gold-right: #805A21;      /* Golden glow zone */
--gold-spot: #D49A38;       /* Spotlight center */
--gold-main: #F2C243;       /* Primary accent */
--gold-deep: #B8861E;       /* Deep shadow */
--gold-highlight: #FFD778;  /* Bright highlight */
```

### The `.gold-background` Class

Applied to the root `<body>` element in `src/app/layout.tsx`:

**Gradient Composition:**
1. **Linear Gradient (90deg):** Creates the horizontal black-to-gold flow
   - Left: `#000000` (Black)
   - Center (45%): `#1A1208` (Warm transition)
   - Right: `#805A21` (Gold glow zone)

2. **Radial Gradient (Spotlight):** Adds depth and focus at 60% 25%
   - Center: `rgba(212,154,56,0.12)` (Spotlight glow at 12% opacity)
   - Creates a subtle "glowing" effect

**Key Properties:**
- `background-attachment: fixed` — Prevents scrolling, keeps gradient in viewport
- `background-repeat: no-repeat` — Shows gradient once across full screen
- `background-size: cover` — Ensures full coverage
- Fixed z-index layering via `::before` pseudo-element

## Architecture

### Root Layout (`src/app/layout.tsx`)
```tsx
<body className={cn(
  'min-h-screen w-full font-body antialiased gold-background',
  fontBody.variable,
  fontHeadline.variable
)}>
```

**Applies to:**
- All pages at `/`
- All pages at `/firms`
- All pages at `/offers`
- All pages at `/login`
- All pages at `/account`
- All pages at `/ai-matcher`
- All pages at `/admin/*`

### Admin Layout (`src/app/admin/layout.tsx`)
```tsx
<main className="flex-1 p-4 sm:p-6 relative z-10 bg-black/30 backdrop-blur-sm">
```

- Inherits gold-background from root
- Adds semi-transparent black overlay for contrast
- Backdrop blur for modern glassmorphism effect

### Page Files
All page files now have their explicit gradient declarations removed:

**Before:**
```tsx
<div className="relative w-full min-h-screen bg-gradient-to-br from-slate-950 via-indigo-950 to-violet-900">
```

**After:**
```tsx
<div className="relative w-full min-h-screen overflow-hidden">
```

Pages automatically inherit the gold-background from the root layout.

## Coverage

### Pages Updated ✅

- `src/app/page.tsx` — Home page
- `src/app/firms/page.tsx` — Firms listing
- `src/app/firms/[slug]/page.tsx` — Firm detail (inherits)
- `src/app/offers/page.tsx` — Offers listing
- `src/app/login/page.tsx` — Login/register
- `src/app/account/page.tsx` — Account page (inherits)
- `src/app/ai-matcher/page.tsx` — AI matcher (inherits)
- `src/app/admin/layout.tsx` — Admin layout (inherits + overlay)
- `src/app/admin/dashboard/page.tsx` — Dashboard (inherits)
- `src/app/admin/firms/page.tsx` — Manage firms (inherits)
- `src/app/admin/offers/page.tsx` — Manage offers (inherits)
- `src/app/admin/reviews/page.tsx` — Manage reviews (inherits)
- `src/app/admin/users/page.tsx` — User management (inherits)
- `src/app/admin/promo-cards/page.tsx` — Promo cards (updated)

### Tailwind Configuration

Added gold color utilities in `tailwind.config.ts`:

```typescript
gold: {
  main: 'var(--gold-main)',
  deep: 'var(--gold-deep)',
  highlight: 'var(--gold-highlight)',
  light: 'var(--gold-left)',
  mid: 'var(--gold-mid)',
  right: 'var(--gold-right)',
  spot: 'var(--gold-spot)',
}
```

**Usage Examples:**
- `text-gold-main` — Gold text
- `border-gold-deep` — Gold borders
- `bg-gold-deep-accent` — Subtle gold background

## Inheritance Flow

```
<html>
  ↓
  <body class="gold-background">
    ├─→ <Header> (inherits)
    ├─→ <main>
    │    ├─→ <page.tsx> (inherits)
    │    └─→ <dynamic routes> (inherit)
    └─→ <Footer> (inherits)
```

For admin pages:
```
<body class="gold-background">
  ↓
  <AdminLayout>
    ↓
    <main class="bg-black/30 backdrop-blur-sm"> (overlay + inherit)
      ↓
      <admin pages> (inherit)
```

## Z-Index Layering

```
-1    Background (::before pseudo-element)
0     Base content
10    Admin main content
20    Admin layout container
```

## Adding New Pages

To add a new page that automatically inherits the background:

1. Create the page file: `src/app/new-route/page.tsx`
2. **Don't add** any background class or gradient
3. Use content wrappers with appropriate z-index:

```tsx
export default function NewPage() {
  return (
    <div className="relative w-full min-h-screen">
      <div className="relative z-10">
        {/* Your content here */}
      </div>
    </div>
  );
}
```

## Customization

### Changing Colors

To adjust colors, update CSS variables in `src/app/globals.css`:

```css
:root {
  --gold-left: #000000;      /* Change black */
  --gold-mid: #1A1208;       /* Change transition */
  --gold-right: #805A21;     /* Change right edge */
  --gold-spot: #D49A38;      /* Change spotlight */
}
```

### Adjusting Gradient Intensity

Modify opacity values in `.gold-background`:

```css
radial-gradient(800px 300px at 60% 25%, 
  rgba(212,154,56,0.12) 0%,    /* Increase/decrease opacity */
  rgba(212,154,56,0.06) 8%,
  transparent 20%)
```

### Spotlight Position

Change the `at 60% 25%` values:
- First value: horizontal position (0-100%)
- Second value: vertical position (0-100%)

Example: `at 50% 50%` centers the spotlight

## Mobile Optimization

The fixed background remains performant on mobile devices:
- Uses `background-attachment: fixed` for smooth scrolling
- No additional DOM elements
- Pure CSS solution

## Browser Support

- Chrome/Edge 90+
- Firefox 88+
- Safari 14+
- Mobile browsers (iOS Safari 14+, Chrome Android)

## Testing the System

### Visual Inspection
Visit each page and verify:
- Consistent black-to-gold gradient visible
- Spotlight glow at top-center area
- Smooth gradient across all pages
- No jarring transitions between routes

### Responsive Testing
Check across device sizes:
- Desktop (1920px+)
- Tablet (768px - 1024px)
- Mobile (320px - 768px)

### Performance
- Use browser DevTools to check:
  - Paint operations (should be minimal)
  - Memory usage (no leaks)
  - GPU acceleration enabled

## Future Enhancements

Possible improvements:
- Animated gradient shifts for special events
- Time-of-day based intensity adjustments
- User preference for gradient darkness
- Page-specific spotlight positions
- Seasonal color variations

## Support

For questions about the background system:
1. Review this documentation
2. Check `src/app/globals.css` for implementation details
3. Review affected page files for usage examples

---

**Last Updated:** December 2024
**System:** PropFirmFusion Global Background Color System v1.0
