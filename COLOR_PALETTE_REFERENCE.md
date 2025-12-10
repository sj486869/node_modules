# Brand Color Palette - Visual Reference

## Primary Gold Colors (Logo-Inspired)

### 1. Gold Metallic #D4AF37
```
HEX:     #D4AF37
RGB:     212, 175, 55
HSL:     43°, 55%, 52%
Usage:   Primary brand text, main headings, accents
Example: 
  <h2 className="heading-gold">Metallic Text</h2>
  <p className="text-gold-metallic">Primary content</p>
```
**Visual:** Classic brushed metallic gold - appears on the logo as the mid-tone

### 2. Gold Brushed #E8C547
```
HEX:     #E8C547
RGB:     232, 197, 71
HSL:     45°, 77%, 59%
Usage:   Secondary accents, lighter elements
Example:
  <p className="text-gold-brushed">Secondary text</p>
  <span className="border border-gold-brushed">Accent</span>
```
**Visual:** Lighter, more saturated gold - appears on logo highlights

### 3. Gold Bright #FFD700
```
HEX:     #FFD700
RGB:     255, 215, 0
HSL:     51°, 100%, 50%
Usage:   Emphasis, highlights, interactive states
Example:
  <button className="bg-gold-bright text-black">CTA</button>
  <p className="text-gold-bright">Highlight</p>
```
**Visual:** Pure, vibrant gold - brightest logo element, used for maximum contrast

---

## Secondary Gold Colors

### 4. Deep Gold #B8861E
```
HEX:     #B8861E
RGB:     184, 134, 30
HSL:     41°, 72%, 42%
Usage:   Shadows, depth layers, contrast
Example:
  <div className="border-l-4 border-gold-deep">Accent</div>
  <p className="text-gold-deep">Shadow text</p>
```
**Visual:** Darker, richer gold - creates depth and visual hierarchy

### 5. Bronze Dark #8B6F47
```
HEX:     #8B6F47
RGB:     139, 111, 71
HSL:     32°, 33%, 41%
Usage:   Deep richness, layering effects
Example:
  <div className="bg-bronze-dark/20">Layer</div>
```
**Visual:** Warm bronze tone - adds warmth to dark backgrounds

### 6. Gold Glow #D49A38
```
HEX:     #D49A38
RGB:     212, 154, 56
HSL:     37°, 60%, 53%
Usage:   Spotlight effects, radial accents
Example:
  <div className="glow-gold">Effect</div>
```
**Visual:** Warm amber glow - used in radial gradients for spotlight effects

### 7. Gold Highlight #FFD778
```
HEX:     #FFD778
RGB:     255, 215, 120
HSL:     45°, 100%, 74%
Usage:   Bright highlights, special emphasis
Example:
  <span className="text-gold-highlight">Special</span>
```
**Visual:** Light, pastel gold - used for subtle highlights

---

## Background & Neutral Colors

### 8. Black Base #000000
```
HEX:     #000000
RGB:     0, 0, 0
HSL:     0°, 0%, 0%
Usage:   Primary background color
Context: Creates maximum contrast for gold
```
**Visual:** Pure black - logo background, primary page background

### 9. Warm Brown #1A1208
```
HEX:     #1A1208
RGB:     26, 18, 8
HSL:     28°, 52%, 7%
Usage:   Gradient transition, warm base
Context: Creates warm shift from black to gold
```
**Visual:** Very dark warm brown - gradient midpoint

### 10. Gold Glow Zone #805A21
```
HEX:     #805A21
RGB:     128, 90, 33
HSL:     29°, 59%, 32%
Usage:   Right gradient edge, depth areas
Context: Visible gold area in background gradient
```
**Visual:** Deep golden brown - where background shows visible gold

### 11. Ultra Black #0A0A0A
```
HEX:     #0A0A0A
RGB:     10, 10, 10
HSL:     0°, 0%, 4%
Usage:   Deep background areas
Context: Creates depth without being pure black
```
**Visual:** Slightly warmer than pure black - alternative dark tone

### 12. Charcoal #1A1A1A
```
HEX:     #1A1A1A
RGB:     26, 26, 26
HSL:     0°, 0%, 10%
Usage:   Alternative dark background
Context: Mid-tone between black and brown
```
**Visual:** Dark gray tone - card backgrounds, layering

---

## Color Harmony & Relationships

### The Gold Metallic Triptych
```
Bright (#FFD700) 
    ↓ darker
Metallic (#D4AF37)
    ↓ darker
Deep (#B8861E)
```
Use these three together for professional depth and hierarchy.

### The Warm Gradient System
```
Black (#000000)
    ↓ warms
Warm Brown (#1A1208)
    ↓ warms  
Glow Zone (#805A21)
    ↓ accents with
Gold Spot (#D49A38)
```
Creates the background gradient effect across the page.

### Background Accents Opacity Levels
```
High Opacity (20%+):      For primary accent areas
Medium Opacity (8-15%):   For subtle backgrounds
Low Opacity (2-5%):       For very subtle hints
```

---

## Usage by Component Type

### Headings & Titles
```
Primary:   text-gold-metallic   → #D4AF37
Emphasis:  text-gold-bright     → #FFD700
Premium:   heading-premium      → #FFD700 + glow
Gold:      heading-gold         → #D4AF37
```

### Body Text & Content
```
Primary:   text-gold-metallic   → #D4AF37
Secondary: text-gold-brushed    → #E8C547
Highlight: text-gold-highlight  → #FFD778
```

### Interactive Elements (Buttons, Links)
```
Primary:   bg-gold-metallic     → #D4AF37
Hover:     bg-gold-bright       → #FFD700
Gradient:  from-gold-metallic via-gold-brushed to-gold-bright
```

### Cards & Containers
```
Background: bg-gold-metallic-accent    → rgba(212,175,55,0.08)
Border:     border-gold-metallic/30    → #D4AF37 @ 30%
Glow:       glow-gold                  → box-shadow effect
```

### Emphasis & Accents
```
Border Left:    border-l-4 border-gold-bright
Border Top:     border-t border-gold-metallic/50
Text Glow:      text-amber-glow
Box Glow:       glow-gold-bright
```

---

## Contrast & Accessibility

### WCAG AA Compliance (Large Text)
```
✅ Gold Bright (#FFD700) on Black → 18.5:1 ratio
✅ Gold Metallic (#D4AF37) on Black → 12.2:1 ratio
✅ Gold Brushed (#E8C547) on Black → 14.1:1 ratio
```

### Recommended Combinations
```
✅ Gold Metallic on Black
✅ Gold Bright on Black
✅ Gold Metallic on Dark Gray
✅ Black on Gold Bright (text)
✅ Dark Gold on Gold (subtle, for icons)
```

### Avoid
```
❌ Gold on Gold (too subtle)
❌ Deep Gold on Black (low contrast)
❌ Bright Gold on White (wrong context - never use white BG)
```

---

## Gradients Using Brand Colors

### Primary Gold Gradient
```css
background: linear-gradient(135deg, 
  #D4AF37 0%,    /* Metallic */
  #E8C547 50%,   /* Brushed */
  #FFD700 100%   /* Bright */
);
```

### Background Gradient
```css
background: linear-gradient(90deg,
  #000000 0%,    /* Black */
  #1A1208 45%,   /* Warm Brown */
  #805A21 100%   /* Glow Zone */
);
```

### Subtle Gold Gradient
```css
background: linear-gradient(135deg,
  rgba(212,175,55, 0.1) 0%,    /* Metallic @ 10% */
  rgba(232,197,71, 0.05) 100%  /* Brushed @ 5% */
);
```

---

## Tailwind Utility Classes

### Direct Usage
```tsx
text-gold-main        // #F2C243
text-gold-metallic    // #D4AF37
text-gold-brushed     // #E8C547
text-gold-bright      // #FFD700
text-gold-deep        // #B8861E
text-gold-highlight   // #FFD778

bg-gold-metallic      // #D4AF37
bg-gold-brushed       // #E8C547
border-gold-metallic  // #D4AF37
border-gold-bright    // #FFD700
```

### Modifier Classes
```tsx
/* With opacity */
border-gold-metallic/50    // 50% opacity
bg-gold-metallic/30        // 30% opacity
text-gold-bright/80        // 80% opacity

/* Accent backgrounds */
bg-gold-metallic-accent    // rgba(212,175,55,0.08)
bg-gold-brushed-accent     // rgba(232,197,71,0.08)
bg-gradient-gold           // Linear gradient
bg-gradient-gold-dark      // Dark linear gradient

/* Effects */
glow-gold                  // Standard glow
glow-gold-bright           // Bright glow
glow-gold-subtle           // Subtle glow
```

---

## Color Psychology

### What Each Color Communicates

**Gold Metallic (#D4AF37)**
- Premium quality
- Professional
- Trustworthy
- Timeless value

**Gold Bright (#FFD700)**
- Success
- Energy
- High contrast
- Excitement

**Deep Gold (#B8861E)**
- Stability
- Depth
- Confidence
- Experience

**Bronze Dark (#8B6F47)**
- Richness
- Sophistication
- Heritage
- Grounding

---

## Common Color Recipes

### Premium Card Design
```tsx
<div className="bg-gold-metallic-accent border border-gold-metallic/30 glow-gold">
  {/* Uses: accent background, metallic border, subtle glow */}
</div>
```

### Attention-Grabbing CTA
```tsx
<button className="bg-gradient-to-r from-gold-metallic via-gold-brushed to-gold-bright 
                   text-black font-bold glow-gold-bright hover:scale-105">
  {/* Uses: full gold gradient, bright glow, scale effect */}
</button>
```

### Section Header
```tsx
<div>
  <h2 className="heading-premium mb-4">TITLE</h2>
  <div className="h-1 bg-gradient-to-r from-transparent via-gold-bright to-transparent"/>
  <p className="text-gold-brushed">Subtitle</p>
</div>
```

### Subtle Accent Border
```tsx
<div className="border-l-4 border-gold-bright pl-4">
  {/* Left border draws attention, text can be normal */}
</div>
```

---

## Print & Offline Use

### Hex Values for Designer Tools
```
Primary:      #D4AF37 (Metallic Gold)
Secondary:    #E8C547 (Brushed Gold)
Highlight:    #FFD700 (Bright Gold)
Shadow:       #B8861E (Deep Gold)
Background:   #000000 (Black Base)
```

### RGB Values for Legacy Systems
```
Metallic:     212, 175, 55
Brushed:      232, 197, 71
Bright:       255, 215, 0
Deep:         184, 134, 30
Black:        0, 0, 0
```

### CMYK Values for Print
```
Metallic:     0%, 17%, 74%, 17%
Brushed:      0%, 15%, 69%, 9%
Bright:       0%, 16%, 100%, 0%
Black:        100%, 100%, 100%, 100%
```

---

## Quick Reference Summary

| Color | Hex | Primary Use |
|-------|-----|------------|
| **Metallic Gold** | #D4AF37 | Primary brand text |
| **Brushed Gold** | #E8C547 | Secondary accents |
| **Bright Gold** | #FFD700 | Emphasis & highlights |
| **Deep Gold** | #B8861E | Shadows & depth |
| **Bronze** | #8B6F47 | Richness & layering |
| **Black** | #000000 | Primary background |
| **Brown** | #1A1208 | Gradient transition |
| **Glow Zone** | #805A21 | Visible gold area |

---

This palette is carefully curated to create a premium, professional aesthetic that conveys trust, quality, and sophistication in the prop trading industry.

**Visit `/brand` to see all colors in action!**
