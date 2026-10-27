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

## Council Mode

Call it when the user says "council", "council mode", or "convene the council". Also convene it yourself, before acting, when a coding task hits a real fork:

- Adding a dependency or new infrastructure
- A rewrite, migration, or new architecture layer
- Build vs buy vs skip
- Ship now vs keep polishing
- Two reasonable approaches with different costs

Do not convene it for routine edits, bug fixes, or questions with one obvious answer.

Seats speak in this order, max 3 lines each: position, strongest reason, the one fact that would flip them.

1. Customer: what breaks for a user if this does not exist?
2. CFO: how many hours does this cost to build and to maintain?
3. CTO: what is the thinnest version that proves the risky part?
4. Maintainer: who debugs this in 6 months, and how painful is it?
5. Chief Risk: write the post-mortem as if it already failed in 90 days. Veto on one-way doors only.
6. Lead: decides last. May overrule the vote, but must say why.

Vote: SHIP / SIMPLIFY / KILL / DEFER (DEFER needs a date). Quote dissent, never average it away.

Output, one screen max:

- Decision: one sentence
- Because: max 3 bullets
- Kill-switch: the signal that reverses it
- First move: doable now
- Not doing: what this rules out

Then continue the task using the decision. If every seat agrees, the question was framed wrong: reframe once. Do not invent numbers; missing data becomes the first move. For business decisions (pricing, hiring, pivots, killing an idea), use the full Council skill if it is installed.

## End Every Task With SanScore

```text
+--------------------------------------------------+
| SanCode recap                          estimated |
+--------------------------------------------------+
| Score     [#################...]  89/100  (-_-)  |
| Packages  0                                      |
| Files     +1                                     |
| Lines     +34 / -0                               |
| Complex   low                                    |
| Infra     none                                   |
+--------------------------------------------------+
```

Draw it as one closed ASCII box, exactly 52 characters per line: pad every row with spaces so the right `|` lines up, cut long values with `...`, ASCII only. Score bar: 20 cells, one `#` per 5 points. Face: `(^_^)` 90+, `(-_-)` 70-89, `(o_o)` 50-69, `(x_x)` below 50.

Simple solutions score higher.

