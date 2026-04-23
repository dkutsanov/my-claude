---
name: Check live DB for column type conventions
description: Always verify column types against the running local database before writing migrations, not just migration scripts
type: feedback
---
When writing Flyway migrations, always check the **live local database** for column type conventions — not just the migration SQL files. Migration scripts may not reflect the current state (e.g., columns may have been altered in later migrations).

**Why:** Migration scripts can be misleading — the baseline may say `varchar(255)` but a later migration may have changed it to `text`. The live DB is the source of truth for current conventions.

**How to apply:** Before writing a CREATE TABLE migration, query `information_schema.columns` for similar columns across existing tables to confirm the correct types. If the local DB isn't running, ask the user to spin it up.
