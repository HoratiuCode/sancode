# Example 2: Search and Authentication

## Search

### AI Slop Solution

The agent adds Elasticsearch, a sync worker, indexing jobs, a search service, ranking configs, and observability dashboards for a product with 200 records.

```text
api/search/
services/SearchIndexer.ts
workers/reindex.ts
infra/elasticsearch.yml
```

Problems:

- Optimizes for a scale that does not exist
- Creates operational burden
- Makes local development slower
- Delays the feature users asked for

### SanCode Solution

Start with database search or in-memory filtering, depending on the app.

```sql
select *
from customers
where lower(name) like lower('%' || ? || '%')
   or lower(email) like lower('%' || ? || '%')
order by created_at desc
limit 50;
```

For a small client-side list:

```js
const results = customers.filter((customer) => {
  const queryText = query.toLowerCase();
  return (
    customer.name.toLowerCase().includes(queryText) ||
    customer.email.toLowerCase().includes(queryText)
  );
});
```

Move to dedicated search when real users complain about relevance, speed, or missing results.

SanScore: 91/100

## Authentication

### AI Slop Solution

The agent builds custom auth:

- Password hashing
- Password reset
- Email verification
- Sessions
- OAuth
- Refresh tokens
- Device management
- Admin impersonation
- Audit logs

Before the app has paying users.

Problems:

- High security risk
- Huge maintenance burden
- Not product differentiation
- Easy to get wrong

### SanCode Solution

Use the auth system already in the stack.

If the platform has auth, use it. If the app is internal, start with a single approved email list or provider login. If the first version is concierge, manually create accounts.

```js
const allowedEmails = new Set(["founder@example.com", "pilot@example.com"]);

export function canAccess(email) {
  return allowedEmails.has(email.toLowerCase());
}
```

For a paid SaaS, use a boring hosted auth provider or the framework's established auth path. Do not invent security to feel productive.

SanScore: 84/100

