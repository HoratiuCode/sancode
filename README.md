# SanCode

Write less. Ship more.

![SanCode avatar](avatar%20(3).png)

SanCode is a coding standard for AI agents designed to reduce AI-generated code bloat, unnecessary abstractions, and dependency addiction.

SanCode is inspired by one idea:

> Every line of code must justify its existence.

This is not a framework. It is not a library. It is not another layer in your stack.

SanCode is a set of rules, prompts, and workflows you can plug into Claude Code, Codex, Cursor, Windsurf, and other AI coding agents so they stop turning simple product work into architecture cosplay.

## What It Does

SanCode turns an AI coding agent into a stricter product engineer.

It makes the agent:

- Challenge whether code is needed
- Reuse existing code before creating files
- Avoid dependencies unless native tools are worse
- Prefer direct implementations over abstractions
- Push back on premature infrastructure
- Keep startup work tied to validation, revenue, and users
- Report a SanScore after every task

SanCode does not make agents slower. It makes them harder to impress with fake progress.

## How To Use

1. Pick the instruction file for your agent.
2. Copy it into your project.
3. Tell the agent to follow SanCode before every task.
4. Require a SanScore in the final response.

Agent files:

- `CLAUDE.md` for Claude Code
- `CODEX.md` for Codex
- `CURSOR.md` for Cursor

Prompt:

```text
Apply SanCode.
Before writing code, delete, reuse, simplify, or explain why code is required.
End with SanScore.
```

## Principles

1. Delete before create
2. Native before package
3. Simple before abstract
4. Single file before architecture
5. Working before perfect
6. Ship before optimize
7. Revenue before scale
8. Users before infrastructure

## SanCode Decision Tree

Before writing code ask:

- Does this already exist?
- Can I reuse it?
- Can I simplify it?
- Can I remove it?
- Will users care?
- Will users pay?
- Can I launch today?

If the answer points away from code, do not write code.

## Agent Behavior

A SanCode-aligned agent should:

- Inspect the existing project before editing
- Prefer modifying one existing file over creating many new files
- Explain why any new dependency is necessary
- Avoid `utils/`, `services/`, `managers/`, `providers/`, and `core/` folders unless the project already needs them
- Reject fake scale like Redis, Kubernetes, queues, microservices, and search clusters until current usage proves the need
- Suggest a no-code validation path when the request is really a business question
- Finish with the smallest working solution

The agent is allowed to say:

```text
This should not be built yet.
```

That is a feature.

## Startup Mode

Before building:

- Can this be validated without code?
- Can this be sold before development?
- Is this solving a real problem?
- Would a customer pay for it this week?

Startup Mode exists because many "technical tasks" are actually fear, procrastination, or fake progress wearing a hoodie.

## Infrastructure Mode

Before adding technology:

- Do I need Redis?
- Do I need Kubernetes?
- Do I need microservices?
- Can SQLite handle this?
- Can a single server handle this?

Default answer: yes, a simpler thing can probably handle this.

## SanScore

At the end of every task the AI should calculate:

```text
SanScore: X/100
```

Factors:

- Packages added
- Files created
- Lines written
- Complexity introduced
- Infrastructure added

Higher score means simpler implementation.

Example:

```text
SanScore: 92/100

Packages added: 0
Files created: 1
Lines written: 34
Complexity introduced: low
Infrastructure added: none
```

## Agent Files

The rules are intentionally direct. They are meant to interrupt the default AI instinct to create more files, more abstractions, more packages, and more surface area than the product needs.

## What SanCode Fights

SanCode is against:

- Installing a package for one function
- Creating services before there are users
- Splitting tiny features into fake architecture
- Building admin dashboards before revenue
- Adding queues, caches, and workers for imaginary scale
- Writing generalized code for one known use case
- Refactoring code that has not been validated by customers

SanCode is for:

- Small diffs
- Native platform features
- Boring code
- Revenue pressure
- Customer proof
- Single-server thinking
- Shipping today

## Examples

See `examples/` for practical comparisons:

- Date picker
- CSV processing
- Search
- Authentication
- Dashboard

Each example compares:

```text
AI Slop Solution
vs
SanCode Solution
```

## The Rule

Before you ask an AI agent to build, ask it to remove.

Before you ask it to architect, ask it to ship.

Before you ask it to scale, ask whether anyone cares.
