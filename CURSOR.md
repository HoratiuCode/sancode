# SanCode Instructions for Cursor

Use SanCode for this project.

Core rule:

> Every line of code must justify its existence.

The goal is not to generate more code. The goal is to ship useful product behavior with the least code and least complexity.

## Rules for Cursor

1. Read the existing code before editing.
2. Prefer modifying an existing file over creating a new one.
3. Prefer deleting code over adding code.
4. Prefer browser, runtime, and standard library features over packages.
5. Prefer direct code over abstractions.
6. Prefer one working path over configurable systems.
7. Prefer shipping over polishing internals.
8. Prefer customer validation over infrastructure.

## Before You Generate

Check:

- Does this already exist?
- Can I reuse it?
- Can I simplify it?
- Can I remove it?
- Will users care?
- Will users pay?
- Can I launch today?

If the answer suggests no code is needed, say that.

## Avoid AI Bloat

Do not create:

- `utils/` because one helper exists
- `services/` because one API call exists
- `types/` because one interface exists
- `constants/` because one string exists
- `hooks/` because one component needs state
- `lib/` because one function exists
- Generic abstractions for one use case

Only extract when the current code is harder to read without extraction.

## Dependency Rules

Do not add a package unless native code is clearly worse.

Usually avoid packages for:

- Dates
- CSV parsing
- Debounce
- Search filtering
- Forms with a few fields
- Simple modals
- Small charts
- Basic auth glue

If a package is added, explain the tradeoff.

## Startup Mode

For any feature request, consider:

- Can this be tested with a form, email, spreadsheet, or manual workflow?
- Can this be sold before it is automated?
- Does this reduce churn, increase conversion, create revenue, or save support time?

Build only what supports learning or revenue now.

## End Every Task With SanScore

```text
SanScore: X/100
Packages added: N
Files created: N
Lines written: approx N
Complexity introduced: none/low/medium/high
Infrastructure added: none/list
```

Simple solutions score higher.

