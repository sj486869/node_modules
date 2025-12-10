-- Add two golden colored promo cards

-- Create table if it doesn't exist
CREATE TABLE IF NOT EXISTS public.promo_cards (
  id SERIAL PRIMARY KEY,
  discount TEXT NOT NULL,
  firm_name TEXT NOT NULL,
  emoji TEXT,
  code TEXT NOT NULL,
  description TEXT,
  link TEXT,
  border_color TEXT,
  gradient_from TEXT,
  gradient_to TEXT,
  button_gradient TEXT,
  accent_color TEXT,
  glow_color TEXT,
  button_glow_color TEXT,
  display_order INTEGER,
  is_active BOOLEAN DEFAULT true,
  UNIQUE (firm_name, code)
);

-- Ensure table exists before inserting
-- First Card: 20% OFF - Noot Funding
INSERT INTO public.promo_cards (
  discount,
  firm_name,
  emoji,
  code,
  description,
  link,
  border_color,
  gradient_from,
  gradient_to,
  button_gradient,
  accent_color,
  glow_color,
  button_glow_color,
  display_order,
  is_active
) VALUES (
  '20%',
  'noot funding',
  '🐝',
  'dkjfkdjfkwj',
  'Get exclusive 20% discount on all trading plans',
  '#',
  'border-yellow-500',
  'from-yellow-400',
  'to-amber-500',
  'from-yellow-400 to-amber-500',
  'text-yellow-400',
  'rgba(250,204,21,0.7)',
  'rgba(250,204,21,0.5)',
  1,
  true
) ON CONFLICT DO NOTHING;

-- Second Card: 100% OFF - 18+ Content
INSERT INTO public.promo_cards (
  discount,
  firm_name,
  emoji,
  code,
  description,
  link,
  border_color,
  gradient_from,
  gradient_to,
  button_gradient,
  accent_color,
  glow_color,
  button_glow_color,
  display_order,
  is_active
) VALUES (
  '100%',
  '!18+ con.....',
  '🔞',
  '18+',
  'Exclusive offer for verified members only',
  '#',
  'border-yellow-500',
  'from-yellow-400',
  'to-amber-500',
  'from-yellow-400 to-amber-500',
  'text-yellow-400',
  'rgba(250,204,21,0.7)',
  'rgba(250,204,21,0.5)',
  2,
  true
) ON CONFLICT DO NOTHING;
