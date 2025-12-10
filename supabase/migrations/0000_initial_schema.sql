-- supabase/seed.sql
-- WARNING: This file truncates data. Do NOT run in production unless intentional.

-- Enable extension for gen_random_uuid
create extension if not exists "pgcrypto";

-- ========== TABLES & SCHEMA ==========

-- Create Profiles table (depends on auth.users existing)
create table if not exists public.profiles (
  id uuid not null references auth.users on delete cascade,
  full_name text null,
  avatar_url text null,
  website text null,
  username text null,
  updated_at timestamp with time zone null,
  constraint profiles_pkey primary key (id),
  constraint username_length check (char_length(coalesce(username, '')) = 0 or char_length(username) >= 3)
);

-- Create Firms table
create table if not exists public.firms (
  id uuid not null default gen_random_uuid(),
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone not null default now(),
  name text not null,
  slug text not null,
  description text null,
  logo_url text null,
  website_url text null,
  country_code character varying null,
  years_in_operation integer null,
  max_allocation integer null,
  assets_supported json null,
  platforms json null,
  verified boolean not null default false,
  rating_avg real not null default 0,
  total_reviews integer not null default 0,
  constraint firms_pkey primary key (id),
  constraint firms_slug_key unique (slug)
);

-- Create Products table
create table if not exists public.products (
  id uuid not null default gen_random_uuid(),
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone not null default now(),
  firm_id uuid not null,
  name text not null,
  type text not null,
  price real not null,
  specs json null,
  payout_split json null,
  rules_link text null,
  constraint products_pkey primary key (id),
  constraint products_firm_id_fkey foreign key (firm_id) references public.firms (id) on delete cascade
);

-- Create Offers table
create table if not exists public.offers (
  id uuid not null default gen_random_uuid(),
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone not null default now(),
  firm_id uuid not null,
  title text not null,
  description text null,
  discount_pct real not null default 0,
  code text null,
  apply_url text not null,
  slug text not null,
  start_date date null,
  end_date date null,
  visible boolean not null default true,
  constraint offers_pkey primary key (id),
  constraint offers_slug_key unique (slug),
  constraint offers_firm_id_fkey foreign key (firm_id) references public.firms (id) on delete cascade
);

-- Create Reviews table
create table if not exists public.reviews (
  id uuid not null default gen_random_uuid(),
  created_at timestamp with time zone not null default now(),
  updated_at timestamp with time zone not null default now(),
  firm_id uuid not null,
  user_id uuid not null,
  rating integer not null,
  title text not null,
  body text null,
  helpful_count integer not null default 0,
  verified boolean not null default false,
  constraint reviews_pkey primary key (id),
  constraint reviews_firm_id_fkey foreign key (firm_id) references public.firms (id) on delete cascade,
  constraint reviews_user_id_fkey foreign key (user_id) references auth.users (id) on delete cascade,
  constraint reviews_rating_check check (rating >= 1 and rating <= 5)
);

-- Create Favorites table
create table if not exists public.favorites (
  user_id uuid not null,
  firm_id uuid not null,
  created_at timestamp with time zone not null default now(),
  constraint favorites_pkey primary key (user_id, firm_id),
  constraint favorites_firm_id_fkey foreign key (firm_id) references public.firms (id) on delete cascade,
  constraint favorites_user_id_fkey foreign key (user_id) references auth.users (id) on delete cascade
);

-- Create Affiliate Clicks table
create table if not exists public.affiliate_clicks (
  id uuid not null default gen_random_uuid(),
  created_at timestamp with time zone not null default now(),
  offer_id uuid not null,
  firm_id uuid not null,
  token text not null,
  ip_addr inet null,
  user_agent text null,
  referer text null,
  constraint affiliate_clicks_pkey primary key (id),
  constraint affiliate_clicks_firm_id_fkey foreign key (firm_id) references public.firms (id) on delete cascade,
  constraint affiliate_clicks_offer_id_fkey foreign key (offer_id) references public.offers (id) on delete cascade
);

-- Create Affiliate Conversions table
create table if not exists public.affiliate_conversions (
  id uuid not null default gen_random_uuid(),
  converted_at timestamp with time zone not null default now(),
  offer_id uuid not null,
  firm_id uuid not null,
  click_id uuid null,
  amount real null,
  status text null,
  raw_payload jsonb null,
  constraint affiliate_conversions_pkey primary key (id),
  constraint affiliate_conversions_click_id_fkey foreign key (click_id) references public.affiliate_clicks (id) on delete set null,
  constraint affiliate_conversions_firm_id_fkey foreign key (firm_id) references public.firms (id) on delete cascade,
  constraint affiliate_conversions_offer_id_fkey foreign key (offer_id) references public.offers (id) on delete cascade
);

-- Create Audit Log table
create table if not exists public.audit_log (
  id bigint generated by default as identity,
  created_at timestamp with time zone not null default now(),
  user_id uuid null,
  action text not null,
  entity_type text null,
  entity_id text null,
  details jsonb null,
  constraint audit_log_pkey primary key (id),
  constraint audit_log_user_id_fkey foreign key (user_id) references auth.users (id) on delete set null
);

-- ========== RLS POLICIES & ENABLE RLS ==========
alter table public.profiles enable row level security;
drop policy if exists "Public profiles are viewable by everyone." on public.profiles;
create policy "Public profiles are viewable by everyone." on public.profiles for select using (true);

drop policy if exists "Users can insert their own profile." on public.profiles;
create policy "Users can insert their own profile." on public.profiles for insert with check (auth.uid() = id);

drop policy if exists "Users can update own profile." on public.profiles;
create policy "Users can update own profile." on public.profiles for update using (auth.uid() = id);

alter table public.firms enable row level security;
drop policy if exists "Firms are viewable by everyone." on public.firms;
create policy "Firms are viewable by everyone." on public.firms for select using (true);

drop policy if exists "Admins can insert firms." on public.firms;
-- Admin insert/update policies intentionally restrictive; change to appropriate auth check as needed
create policy "Admins can insert firms." on public.firms for insert with check (false);

drop policy if exists "Admins can update firms." on public.firms;
create policy "Admins can update firms." on public.firms for update using (false);

alter table public.products enable row level security;
drop policy if exists "Products are viewable by everyone." on public.products;
create policy "Products are viewable by everyone." on public.products for select using (true);

alter table public.offers enable row level security;
drop policy if exists "Offers are viewable by everyone." on public.offers;
create policy "Offers are viewable by everyone." on public.offers for select using (true);

alter table public.reviews enable row level security;
drop policy if exists "Reviews are viewable by everyone." on public.reviews;
create policy "Reviews are viewable by everyone." on public.reviews for select using (true);

drop policy if exists "Users can insert their own reviews." on public.reviews;
create policy "Users can insert their own reviews." on public.reviews for insert with check (auth.uid() = user_id);

drop policy if exists "Users can update their own reviews." on public.reviews;
create policy "Users can update their own reviews." on public.reviews for update using (auth.uid() = user_id);

drop policy if exists "Users can delete their own reviews." on public.reviews;
create policy "Users can delete their own reviews." on public.reviews for delete using (auth.uid() = user_id);

alter table public.favorites enable row level security;
drop policy if exists "Users can view their own favorites." on public.favorites;
create policy "Users can view their own favorites." on public.favorites for select using (auth.uid() = user_id);

drop policy if exists "Users can insert their own favorites." on public.favorites;
create policy "Users can insert their own favorites." on public.favorites for insert with check (auth.uid() = user_id);

drop policy if exists "Users can delete their own favorites." on public.favorites;
create policy "Users can delete their own favorites." on public.favorites for delete using (auth.uid() = user_id);

alter table public.affiliate_clicks enable row level security;
-- clicks are typically inserted server-side with service role, so no public insert policy included.

alter table public.affiliate_conversions enable row level security;
-- conversions generally inserted server-side with service role.

alter table public.audit_log enable row level security;
-- audit_log typically written server-side; allow select only to service roles if necessary

-- ========== TRIGGERS & FUNCTIONS ==========

-- Function to create profile when a new auth.user is created
create or replace function public.handle_new_user() returns trigger language plpgsql security definer as $$
begin
  -- Insert a minimal profile row for the new user (only if not exists)
  begin
    insert into public.profiles (id, full_name, avatar_url, updated_at)
    values (
      new.id,
      coalesce(new.raw_user_meta_data->>'full_name', null),
      coalesce(new.raw_user_meta_data->>'avatar_url', null),
      now()
    );
  exception when unique_violation then
    -- ignore if profile already exists
    null;
  end;
  return new;
end;
$$;

-- Trigger to call handle_new_user after user creation in auth.users
drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
after insert on auth.users
for each row
execute procedure public.handle_new_user();

-- Function to update firm rating average and total reviews
create or replace function public.update_firm_rating(firm_id_input uuid) returns void language plpgsql security definer as $$
declare
  avg_rating real;
  review_count int;
begin
  select avg(rating), count(*) into avg_rating, review_count
  from public.reviews
  where firm_id = firm_id_input;

  update public.firms
  set rating_avg = coalesce(avg_rating, 0),
      total_reviews = coalesce(review_count, 0),
      updated_at = now()
  where id = firm_id_input;
end;
$$;

-- Trigger wrapper for reviews to call update_firm_rating appropriately
create or replace function public.reviews_rating_trigger() returns trigger language plpgsql security definer as $$
begin
  if (TG_OP = 'INSERT') then
    perform public.update_firm_rating(new.firm_id);
    return new;
  elsif (TG_OP = 'UPDATE') then
    -- if firm_id changed, update both; otherwise update the single firm
    if (old.firm_id is distinct from new.firm_id) then
      perform public.update_firm_rating(old.firm_id);
      perform public.update_firm_rating(new.firm_id);
    else
      perform public.update_firm_rating(new.firm_id);
    end if;
    return new;
  elsif (TG_OP = 'DELETE') then
    perform public.update_firm_rating(old.firm_id);
    return old;
  end if;
  return null;
end;
$$;

-- Create trigger on reviews for insert/update/delete
drop trigger if exists on_new_review on public.reviews;
create trigger on_new_review
after insert or update or delete on public.reviews
for each row
execute procedure public.reviews_rating_trigger();

-- ========== SEED (truncate then insert sample data) ==========

-- Truncate dependent tables in proper order (preserve auth.users)
truncate table public.affiliate_conversions, public.affiliate_clicks, public.favorites, public.reviews, public.offers, public.products, public.firms, public.profiles, public.audit_log cascade;

-- Insert sample firms
insert into public.firms (name, slug, description, logo_url, website_url, country_code, years_in_operation, verified, platforms, assets_supported, max_allocation)
values
('FTMO', 'ftmo', 'A popular prop firm known for its rigorous evaluation process and robust trading platform.', 'https://picsum.photos/seed/ftmo-logo/200/100', 'https://ftmo.com', 'CZ', 7, true, '["mt4", "mt5", "ctrader"]', '["forex", "indices", "crypto", "commodities"]', 200000),
('Topstep', 'topstep', 'Specializing in futures trading, Topstep offers a simple one-step evaluation to get funded.', 'https://picsum.photos/seed/topstep-logo/200/100', 'https://topstep.com', 'US', 10, true, '["custom", "mt5"]', '["futures"]', 150000),
('The Funded Trader', 'the-funded-trader', 'Offers multiple challenge types, including rapid and standard challenges, with high profit splits.', 'https://picsum.photos/seed/tft-logo/200/100', 'https://thefundedtraderprogram.com', 'US', 3, false, '["mt4", "mt5"]', '["forex", "indices", "commodities"]', 400000),
('My Forex Funds', 'my-forex-funds', 'A widely used firm with various funding models, though it has faced regulatory challenges.', 'https://picsum.photos/seed/mff-logo/200/100', 'https://myforexfunds.com', 'CA', 4, false, '["mt4", "mt5"]', '["forex", "indices"]', 300000),
('True Forex Funds', 'true-forex-funds', 'Known for its rapid funding options and straightforward rules.', 'https://picsum.photos/seed/tff-logo/200/100', 'https://trueforexfunds.com', 'HU', 2, true, '["mt4", "mt5"]', '["forex", "indices", "crypto"]', 200000),
('Apex Trader Funding', 'apex-trader-funding', 'A leader in futures funding with frequent discounts and a large community.', 'https://picsum.photos/seed/apex-logo/200/100', 'https://apextraderfunding.com', 'US', 3, true, '["custom"]', '["futures"]', 300000);

-- Insert sample offers (using firm ids resolved by slug)
insert into public.offers (firm_id, title, slug, apply_url, discount_pct, end_date, visible, description)
select id, '10% Off All Challenges', 'ftmo-10-off', 'https://ftmo.com/en/sign-up/', 10, current_date + interval '30 day', true, 'FTMO promo - 10% off'
from public.firms where slug = 'ftmo';

insert into public.offers (firm_id, title, slug, apply_url, discount_pct, end_date, visible, description)
select id, '20% Discount on 50K Account', 'topstep-20-50k', 'https://www.topstep.com/buy-a-trading-combine/', 20, current_date + interval '15 day', true, 'Topstep 50K promo'
from public.firms where slug = 'topstep';

insert into public.offers (firm_id, title, slug, apply_url, discount_pct, end_date, visible, description)
select id, '5% Off + 90% Payout', 'tft-5-off-90-payout', 'https://thefundedtraderprogram.com/select-challenge/', 5, null, true, 'TFT recurring 5% + special payout option'
from public.firms where slug = 'the-funded-trader';

-- Optional expired example for testing
insert into public.offers (firm_id, title, slug, apply_url, discount_pct, end_date, visible, description)
select id, 'Expired Offer Example', 'tft-expired', 'https://thefundedtraderprogram.com/select-challenge/', 50, current_date - interval '1 day', true, 'Expired test offer'
from public.firms where slug = 'the-funded-trader';

-- Insert additional offers from previous sample (avoid duplicates)
insert into public.offers (firm_id, title, slug, discount_pct, apply_url, end_date, description, visible)
select id, '15% OFF all challenges!', 'ftmo-15-off', 15, 'https://ftmo.com/en/start-challenge/', current_date + interval '30 day', 'Get a 15% discount on any FTMO Challenge. Limited time offer for new traders.', true
from public.firms where slug = 'ftmo'
on conflict (slug) do nothing;

insert into public.offers (firm_id, title, slug, discount_pct, apply_url, end_date, description, visible)
select id, '20% Discount + 90% Payout', 'topstep-20-off', 20, 'https://www.topstep.com/trading-combine/', current_date + interval '15 day', 'A special promotion offering a 20% discount on the Trading Combine and an increased 90% payout for the first month.', true
from public.firms where slug = 'topstep'
on conflict (slug) do nothing;

insert into public.offers (firm_id, title, slug, discount_pct, apply_url, description, visible)
select id, 'Standard Challenge 10% Off', 'tft-standard-10', 10, 'https://thefundedtraderprogram.com/standard-challenge/', 'A recurring offer for a 10% discount on their popular Standard Challenge accounts.', true
from public.firms where slug = 'the-funded-trader'
on conflict (slug) do nothing;

-- Insert Products
insert into public.products (firm_id, name, type, price, specs)
select id, '$100k Challenge', '2-Step Challenge', 540,
  json_build_object(
    'account_size', 100000,
    'profit_target_1', '10%',
    'profit_target_2', '5%',
    'max_daily_drawdown', '5%',
    'max_overall_drawdown', '10%'
  )
from public.firms where slug = 'ftmo'
on conflict (id, name) do nothing;

insert into public.products (firm_id, name, type, price, specs)
select id, '$50k Trading Combine', '1-Step Challenge', 165,
  json_build_object(
    'account_size', 50000,
    'profit_target', '$3,000',
    'max_daily_drawdown', '$1,000',
    'max_trailing_drawdown', '$2,000'
  )
from public.firms where slug = 'topstep'
on conflict (id, name) do nothing;

insert into public.products (firm_id, name, type, price, specs)
select id, '$200k Royal Challenge', '2-Step Challenge', 939,
  json_build_object(
    'account_size', 200000,
    'profit_target_1', '8%',
    'profit_target_2', '5%',
    'max_daily_drawdown', '5%',
    'max_overall_drawdown', '10%'
  )
from public.firms where slug = 'the-funded-trader'
on conflict (id, name) do nothing;

-- Note: reviews should be inserted by authenticated users in the app.
-- Example (commented) - requires an actual auth.users row:
-- with user_data as (select id from auth.users limit 1), firm_data as (select id from public.firms where slug = 'ftmo')
-- insert into public.reviews (firm_id, user_id, rating, title, body, verified)
-- select firm_data.id, user_data.id, 5, 'Best in the business', 'FTMO has a solid reputation for a reason...', true
-- from user_data, firm_data;

-- After seed inserts, update rating aggregates for all firms
do $$
declare
  rec record;
begin
  for rec in select id from public.firms loop
    perform public.update_firm_rating(rec.id);
  end loop;
end;
$$;

    