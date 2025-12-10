# PropFirmFusion

Welcome to PropFirmFusion, a comparison and affiliate marketplace for prop trading firms, built with Next.js and Supabase.

This application provides a platform for traders to browse, compare, and review prop trading firms. It features an AI-powered matching tool, affiliate tracking, and secure user authentication.

## Features

- **Firm Directory**: Browse a comprehensive directory of prop firms with detailed profiles.
- **Offer Aggregation**: View and apply for special offers from various firms.
- **AI-Powered Matching**: Get personalized firm recommendations based on your trading style.
- **User Reviews**: Read and write reviews for firms.
- **Affiliate System**: Securely tracks affiliate clicks and conversions.
- **User Accounts**: Sign up, log in, and manage your favorite firms.
- **Secure by Default**: Utilizes Supabase's Row-Level Security (RLS) to protect user data.

## Tech Stack

- **Framework**: Next.js (App Router)
- **Styling**: Tailwind CSS & shadcn/ui
- **Backend**: Supabase (Auth, Postgres, Storage)
- **AI**: Google Genkit

---

## Getting Started

Follow these steps to get the application running locally.

### 1. Prerequisites

- Node.js (v18 or later)
- A Supabase account

### 2. Clone the Repository

```bash
git clone <your-repo-url>
cd PropFirmFusion
```

### 3. Install Dependencies

```bash
npm install
```

### 4. Set Up Environment Variables

Create a `.env.local` file in the root of the project by copying the example file:

```bash
cp .env.example .env.local
```

Now, fill in the `.env.local` file with your credentials:

- `NEXT_PUBLIC_SUPABASE_URL`: Your Supabase project URL.
- `NEXT_PUBLIC_SUPABASE_ANON_KEY`: Your Supabase project `anon` key.
- `SUPABASE_SERVICE_ROLE_KEY`: Your Supabase project `service_role` key.
- `ADMIN_IMPORT_SECRET`: A secure, random string for protecting the admin import API. Generate one with `openssl rand -hex 32`.
- `AFFILIATE_WEBHOOK_SECRET`: A secure, random string for verifying affiliate webhooks. Generate one with `openssl rand -hex 32`.

You can find your Supabase keys in your project's **Dashboard > Project Settings > API**.

### 5. Set Up the Database

The database schema, including tables, triggers, and Row-Level Security (RLS) policies, needs to be set up in your Supabase project.

1.  Navigate to the **SQL Editor** in your Supabase dashboard.
2.  Copy the entire content of `supabase/migrations/0000_initial_schema.sql` and run it. This will create all the necessary tables and security policies.
3.  (Optional) To populate your database with sample data, copy the content of `supabase/seed.sql` and run it in the SQL Editor.

### 6. Run the Development Server

You can now start the Next.js development server:

```bash
npm run dev
```

The application should be running at [http://localhost:9002](http://localhost:9002).

---

## Deployment

This application is optimized for deployment on [Vercel](https://vercel.com/).

1.  Push your code to a Git repository (e.g., GitHub, GitLab).
2.  Import your project into Vercel.
3.  Configure the Environment Variables in the Vercel project settings. Use the same variables from your `.env.local` file.
4.  Deploy! Vercel will automatically build and deploy your Next.js application.

---

## Security Checklist

**IMPORTANT**: Follow these guidelines to keep your application and user data secure.

1.  **Keep Secrets Secret**: Never commit your `.env.local` file or any other file containing secrets to version control. The `.gitignore` file is already configured to ignore it.

2.  **Use Strong Secrets**: For `ADMIN_IMPORT_SECRET` and `AFFILIATE_WEBHOOK_SECRET`, use cryptographically secure random strings. Do not use guessable passwords.

3.  **Rotate Keys if Leaked**: If any of your Supabase keys or application secrets are accidentally exposed, **rotate them immediately**.
    -   **Supabase Keys**: Go to your project's **API settings** to reissue keys.
    -   **Application Secrets**: Generate new secrets and update your environment variables in `.env.local` and your deployment provider (Vercel).

4.  **Restrict `service_role` Key Usage**: The `SUPABASE_SERVICE_ROLE_KEY` has full access to your database and bypasses all RLS policies. It should **NEVER** be exposed on the client side. Only use it in server-side code (Server Components, Route Handlers, Server Actions).

5.  **Enable Row-Level Security (RLS)**: RLS is enabled on all sensitive tables in the provided migration script. Do not disable it unless you fully understand the security implications. Always define "deny-by-default" policies.

---

## API & Testing Examples

Here are some `cURL` examples for testing the API endpoints.

### List Firms (Anonymous)

This endpoint is public.

```bash
curl 'https://[YOUR_SUPABASE_URL]/rest/v1/firms?select=*' \
  -H "apikey: [YOUR_SUPABASE_ANON_KEY]" \
  -H "Authorization: Bearer [YOUR_SUPABASE_ANON_KEY]"
```

### Create a Review (Authenticated)

This requires a valid JWT from an authenticated user.

```bash
# First, log in to get a JWT.
# Then, use the JWT in the Authorization header.

curl -X POST 'https://[YOUR_SUPABASE_URL]/rest/v1/reviews' \
  -H "apikey: [YOUR_SUPABASE_ANON_KEY]" \
  -H "Authorization: Bearer [USER_JWT_TOKEN]" \
  -H "Content-Type: application/json" \
  -d '{
    "firm_id": "the_firm_uuid",
    "user_id": "the_user_uuid",
    "rating": 5,
    "title": "Excellent Firm!",
    "body": "This is a great prop firm with excellent support."
  }'
```

### Affiliate Redirect Link

Visiting this URL in your browser will log a click and redirect you.

```
https://[YOUR_SITE_URL]/api/r/[offer_slug_or_token]
```

### Affiliate Conversion Webhook

This endpoint is protected by an HMAC signature.

**Example Payload (`payload.json`):**
```json
{"click_id":"some_click_uuid","offer_id":"some_offer_uuid","firm_id":"some_firm_uuid","amount":100,"status":"completed"}
```

**Generate Signature (example in Node.js):**
```javascript
const crypto = require('crypto');
const secret = process.env.AFFILIATE_WEBHOOK_SECRET;
const payload = JSON.stringify(require('./payload.json'));
const signature = `sha256=${crypto.createHmac('sha256', secret).update(payload).digest('hex')}`;
console.log(signature);
```

**cURL Request:**

```bash
curl -X POST https://[YOUR_SITE_URL]/api/webhook/affiliate-conversion \
  -H "X-Hub-Signature-256: [GENERATED_SIGNATURE]" \
  -H "Content-Type: application/json" \
  -d @payload.json
```
The server will return `401 Unauthorized` if the signature is invalid.
