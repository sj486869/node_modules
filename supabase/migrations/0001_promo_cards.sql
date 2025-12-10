-- Create Promo Cards table for managing featured trading offers
create table if not exists public.promo_cards (
  id uuid not null default gen_random_uuid(),
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone not null default now(),
  discount text not null,
  firm_name text not null,
  emoji text not null,
  code text not null,
  description text not null,
  link text null,
  border_color text not null default 'border-green-400',
  gradient_from text not null default 'from-green-400',
  gradient_to text not null default 'to-green-500',
  button_gradient text not null default 'from-green-400 to-green-500',
  accent_color text not null default 'text-green-400',
  glow_color text not null default 'rgba(74,222,128,0.7)',
  button_glow_color text not null default 'rgba(74,222,128,0.5)',
  display_order integer not null default 0,
  is_active boolean not null default true,
  constraint promo_cards_pkey primary key (id)
);

-- Enable RLS
alter table public.promo_cards enable row level security;

-- Create RLS policies
-- Allow public to select active promo cards
create policy "promo_cards_select_public" on public.promo_cards
  for select using (is_active = true);

-- Allow authenticated users to select all promo cards (for admin preview)
create policy "promo_cards_select_authenticated" on public.promo_cards
  for select using (auth.role() = 'authenticated');

-- Allow authenticated users (admins) to insert
create policy "promo_cards_insert_authenticated" on public.promo_cards
  for insert with check (auth.role() = 'authenticated');

-- Allow authenticated users (admins) to update
create policy "promo_cards_update_authenticated" on public.promo_cards
  for update using (auth.role() = 'authenticated');

-- Allow authenticated users (admins) to delete
create policy "promo_cards_delete_authenticated" on public.promo_cards
  for delete using (auth.role() = 'authenticated');

-- Create indexes
create index if not exists promo_cards_is_active_idx on public.promo_cards(is_active);
create index if not exists promo_cards_display_order_idx on public.promo_cards(display_order);
