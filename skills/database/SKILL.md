---
name: database
description: Use when writing or reviewing database schema changes — Flyway migrations, CREATE/ALTER TABLE, new columns, indexes, or constraint changes. TRIGGER when the user adds/edits files under migrations/, db/migration/, flyway/, or mentions schema/column/migration work. DO NOT trigger for application-level ORM/query changes that don't alter schema.
---

# Database

Guidance for database schema work (migrations, column additions, new tables, index changes) across this workspace's backend repos.

## Core rule: trust the live DB, not the migration scripts

When you need to know the current state of a table — column types, nullability, indexes, default values — **query the running local database directly**, not the Flyway (or other) migration SQL files.

**Why:** A baseline migration may declare `varchar(255)`, but a later migration may have changed it to `text`, or dropped/re-added the column with different settings. Reading only the baseline gives you a type that no longer matches production. The live DB is the only source of truth for the current schema.

### How to apply

Before writing a `CREATE TABLE`, `ALTER TABLE`, or any migration that adds a column to an existing table:

1. **Find similar columns in existing tables** by querying `information_schema.columns`. Examples:

   ```sql
   -- What types are used for columns named `customer_id` across the DB?
   SELECT table_name, column_name, data_type, character_maximum_length, is_nullable, column_default
     FROM information_schema.columns
    WHERE column_name = 'customer_id'
    ORDER BY table_name;

   -- What does a specific table look like right now?
   SELECT column_name, data_type, character_maximum_length, is_nullable, column_default
     FROM information_schema.columns
    WHERE table_name = 'alert'
    ORDER BY ordinal_position;
   ```

2. **Pick types consistent with existing conventions** observed in the live DB, not with the oldest migration that happens to be nearby.

3. **If the local DB is not running**, stop and ask the user to spin it up rather than guessing from migration files. A wrong type in a migration is expensive to fix once it's on main.

## When you can skip the live-DB check

- You're editing a migration that has not yet been committed and run locally (you're the one defining the schema fresh).
- The change is purely a data migration (e.g. `UPDATE ... SET ...`) that doesn't care about column types.
- You're reverting a migration and the rollback is a verbatim inverse.
