-- This script seeds the database with some initial data for development.
-- Clear existing data
-- Note: Be cautious running this in production.
-- delete from reviews;
-- delete from products;
-- delete from offers;
-- delete from firms;

-- Insert Firms
insert into firms (slug, name, description, logo_url, website_url, country_code, years_in_operation, verified, platforms, assets_supported, max_allocation) values
(
  'ftmo',
  'FTMO',
  'FTMO is a proprietary trading firm that provides an opportunity for traders to showcase their skills and potentially trade with the firm''s capital. They are known for their rigorous 2-step evaluation process.',
  'https://images.unsplash.com/photo-1633431406066-27dc4345ca98?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw5fHxsb2dvJTIwYmx1ZXxlbnwwfHx8fDE3NjQ2ODE3OTF8MA&ixlib=rb-4.1.0&q=80&w=1080',
  'https://ftmo.com',
  'CZ',
  8,
  true,
  '["mt4", "mt5", "ctrader"]',
  '["forex", "indices", "crypto", "commodities", "stocks"]',
  400000
),
(
  'topstep',
  'Topstep',
  'Topstep focuses on futures trading and offers a one-step evaluation called the Trading Combine®. Successful traders get access to a funded account without risking their own capital.',
  'https://images.unsplash.com/photo-1605574931378-0be0786247c0?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw3fHxsb2dvJTIwZ3JlZW58ZW58MHx8fHwxNzY0NjgxNzkwfDA&ixlib=rb-4.1.0&q=80&w=1080',
  'https://topstep.com',
  'US',
  11,
  true,
  '["ninjatrader", "tradestation", "custom"]',
  '["futures"]',
  150000
),
(
  'the-funded-trader',
  'The Funded Trader',
  'A popular prop firm offering various challenge types, including Standard, Rapid, and Royal challenges. They support a wide range of instruments and have a scaling plan.',
  'https://images.unsplash.com/photo-1747687759065-0c415cc1cf28?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxMHx8bG9nbyUyMGRhcmt8ZW58MHx8fHwxNzY0NjgxNzkwfDA&ixlib=rb-4.1.0&q=80&w=1080',
  'https://thefundedtraderprogram.com',
  'US',
  3,
  false,
  '["mt4", "mt5"]',
  '["forex", "indices", "crypto", "commodities"]',
  600000
),
(
  'myforexfunds',
  'My Forex Funds',
  'Offering three programs: Rapid, Evaluation, and Accelerated, to cater to different trader experience levels. They were one of the largest firms before facing regulatory issues.',
  'https://images.unsplash.com/photo-1633886897663-44c707d71904?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHw1fHxsb2dvJTIwcmVkfGVufDB8fHx8MTc2NDY4MTc5MHww&ixlib=rb-4.1.0&q=80&w=1080',
  'https://myforexfunds.com',
  'CA',
  4,
  false,
  '["mt4", "mt5"]',
  '["forex", "indices"]',
  300000
),
(
  'true-forex-funds',
  'True Forex Funds',
  'Known for its straightforward 1-Phase and 2-Phase funding programs. They offer competitive profit splits and quick payouts, making them a popular choice for forex traders.',
  'https://images.unsplash.com/photo-1608550742884-68021295cd82?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3NDE5ODJ8MHwxfHNlYXJjaHwxMHx8bG9nbyUyMHByb2Zlc3Npb25hbHxlbnwwfHx8fDE3NjQ2ODE3OTF8MA&ixlib=rb-4.1.0&q=80&w=1080',
  'https://trueforexfunds.com/',
  'HU',
  3,
  true,
  '["mt5"]',
  '["forex", "indices", "commodities", "crypto"]',
  400000
);

-- Insert Offers
insert into offers (firm_id, title, slug, discount_pct, apply_url, end_date, description)
select 
  id,
  '15% OFF all challenges!',
  'ftmo-15-off',
  15,
  'https://ftmo.com/en/start-challenge/',
  current_date + interval '30 day',
  'Get a 15% discount on any FTMO Challenge. Limited time offer for new traders.'
from firms where slug = 'ftmo';

insert into offers (firm_id, title, slug, discount_pct, apply_url, end_date, description)
select 
  id,
  '20% Discount + 90% Payout',
  'topstep-20-off',
  20,
  'https://www.topstep.com/trading-combine/',
  current_date + interval '15 day',
  'A special promotion offering a 20% discount on the Trading Combine and an increased 90% payout for the first month.'
from firms where slug = 'topstep';

insert into offers (firm_id, title, slug, discount_pct, apply_url, description)
select 
  id,
  'Standard Challenge 10% Off',
  'tft-standard-10',
  10,
  'https://thefundedtraderprogram.com/standard-challenge/',
  'A recurring offer for a 10% discount on their popular Standard Challenge accounts.'
from firms where slug = 'the-funded-trader';


-- Insert Products
insert into products (firm_id, name, type, price, specs)
select 
  id,
  '$100k Challenge',
  '2-Step Challenge',
  540,
  '{ "account_size": 100000, "profit_target_1": "10%", "profit_target_2": "5%", "max_daily_drawdown": "5%", "max_overall_drawdown": "10%" }'
from firms where slug = 'ftmo';

insert into products (firm_id, name, type, price, specs)
select 
  id,
  '$50k Trading Combine',
  '1-Step Challenge',
  165,
  '{ "account_size": 50000, "profit_target": "$3,000", "max_daily_drawdown": "$1,000", "max_trailing_drawdown": "$2,000" }'
from firms where slug = 'topstep';

insert into products (firm_id, name, type, price, specs)
select 
  id,
  '$200k Royal Challenge',
  '2-Step Challenge',
  939,
  '{ "account_size": 200000, "profit_target_1": "8%", "profit_target_2": "5%", "max_daily_drawdown": "5%", "max_overall_drawdown": "10%" }'
from firms where slug = 'the-funded-trader';

-- Note: We are not inserting reviews or users here as that should happen
-- through the application's user interface.
-- You can manually sign up as a user and create reviews.
-- Example of inserting a review (requires a valid user_id and firm_id):
/*
with user_data as (
  select id from auth.users limit 1
),
firm_data as (
  select id from firms where slug = 'ftmo'
)
insert into reviews (firm_id, user_id, rating, title, body)
select firm_data.id, user_data.id, 5, 'Best in the business', 'FTMO has a solid reputation for a reason. The process is tough but fair, and payouts are reliable.'
from user_data, firm_data;

-- Don't forget to update the firm's rating after inserting a review
select update_firm_rating((select id from firms where slug = 'ftmo'));
*/

-- Update ratings for all firms based on initial seed or existing reviews
select update_firm_rating(id) from firms;
