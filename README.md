# SanCode

Write less. Ship more.

![SanCode avatar](avatar%20(3).png)

SanCode is a coding standard for AI agents that cuts AI-generated code bloat, unnecessary abstractions, and dependency addiction.

> Every line of code must justify its existence.

It is not a framework, a library, or another layer in your stack. It is a set of rules, and now a **skill with a brain**, that you plug into Claude Code, Codex, Cursor, OpenClaw, Hermes Agent, Windsurf, Claude chat, and Claude Cowork so they stop turning simple product work into architecture cosplay.

![SanCode brain: the loop, the modes, and the SanScore card](assets/sancode-brain.svg)

## Quick Start

**Option 1: the skill (recommended).** One command. It finds Claude Code, Hermes, and OpenClaw on your machine and installs into each.

```bash
curl -fsSL https://raw.githubusercontent.com/HoratiuCode/sancode/main/install.sh | sh
```

```text
SanCode installer
[x] claude       v2.4.0   ~/.claude/skills/sancode
[x] hermes       v2.4.0   ~/.hermes/skills/sancode
[ ] openclaw     not found
Done. Open any project and ask for code: SanCode runs setup on first use.
```

| Action | Command |
|---|---|
| Update | `curl -fsSL https://raw.githubusercontent.com/HoratiuCode/sancode/main/install.sh \| sh -s -- --update` |
| Uninstall | `curl -fsSL https://raw.githubusercontent.com/HoratiuCode/sancode/main/install.sh \| sh -s -- --uninstall` |
| One agent only | `... \| sh -s -- --only claude` |

Updates never touch your project brains. They upgrade themselves on the next task and tell you what's new. Prefer manual? Copy `skill/sancode` into `~/.claude/skills/`, `~/.hermes/skills/`, or `~/.openclaw/workspace/skills/`.

**Claude chat and Cowork.** One upload covers both: they share your skill library.

```bash
curl -fsSL https://raw.githubusercontent.com/HoratiuCode/sancode/main/install.sh | sh -s -- --zip     # writes sancode.zip
```

Upload `sancode.zip` at claude.ai under **Settings → Capabilities → Skills** (paid plan, code execution on). It works in chat right away and appears in Cowork automatically.

**Option 2: one rules file.** Any agent, no memory. Copy the file for your agent into your project:

| Agent | File | Where it goes |
|---|---|---|
| Claude Code | `CLAUDE.md` | project root |
| Codex | `CODEX.md` | project root |
| Cursor | `CURSOR.md` | project root |
| OpenClaw | `OPENCLAW.md` | paste into `~/.openclaw/workspace/AGENTS.md` |
| Hermes Agent | `HERMES.md` | project root (Hermes loads it before `AGENTS.md`) |

Or just prompt:

```text
Apply SanCode.
Before writing code, delete, reuse, simplify, or explain why code is required.
End with SanScore.
```

## Where It Runs

| Surface | Brain lives in | SanScore | Model routing |
|---|---|---|---|
| **Claude Code, Codex, Hermes, OpenClaw** | `.sancode/brain.md` in the repo | measured from git | suggest / auto |
| **Claude Cowork** | `.sancode/brain.md` in the folder you chose | estimated (measured if git) | suggest |
| **Claude chat** (web, desktop, mobile) | `sancode-brain.md` in your Project files | estimated | suggest via model picker |

In chat, Claude can't save files between conversations, so you keep the brain: after setup SanCode prints it once for you to save as a Project file. After that it only prints a short `Brain update` with the lines to add, and only when it learned something. Instead of checking git, it asks once: "Last time: add search. Did you keep it, change it, or drop it?"

## How the Brain Works

Every task runs the same loop:

| Step | What happens |
|---|---|
| **0 Setup** | First run only. Reads your repo, then asks how you think and code. |
| **1 Recall** | Reads `.sancode/brain.md`. Checks git for what happened to its past code. Flags decisions due for review. |
| **2 Route** | Picks Coding, Startup, or Council Mode. |
| **3 Act** | Makes the smallest working change. Checks the Reuse map before writing anything new. |
| **4 Score** | Measures the change from `git diff` and prints the SanScore. |
| **5 Learn** | Saves only what changes the next decision. |

### Setup

The first time SanCode runs in a project, it reads your package files, configs, and README, shows what it found, and offers a preset:

| Preset | Strict | Work | Council | Brain | Visual | Models |
|---|---|---|---|---|---|---|
| **Solo founder** (default) | strict | plan briefly then code | at real forks | private | card | suggest |
| **Team repo** | balanced | explain options and wait | at real forks | shared | bar | suggest |
| **Prototype** | relaxed | just code | off | private | bar | auto |

A preset answers most questions. You only fill in what it can't know:

1. What are you building, and what stage? (idea / pre-revenue / paying users)
2. How strict should I be? (strict / balanced / relaxed)
3. Non-negotiables: tools or choices I must never argue with?
4. Your rules: things I must always or never do?
5. How do you work? (just code / plan briefly then code / explain options and wait)
6. When should the council convene? (at real forks / only when asked / off)
7. Brain shared (commit it) or private (`.gitignore`)?
8. Show the score as a picture? (off / bar / card)
9. Pick the model by task difficulty? (suggest / auto / off)

Every question has a default. Say "defaults" to skip. **Your rules always beat SanCode's.** Rerun anytime with `sancode setup`.

### It learns from what happens to its code

Next session, SanCode checks git for what you did to the code it wrote:

- **kept**: still there, good sign
- **rewritten**: it reads your change, works out what you preferred, and saves a lesson
- **reverted**: it saves why

```text
[outcome] user replaced my fetch wrapper with plain fetch calls: don't wrap fetch
```

From then on it follows that lesson like a direct instruction. If you overrule it once in chat, it stops arguing.

### Home screen

Say `sancode status` to open the brain:

```text
+--------------------------------------------------+
| SanCode status                    v2.4 - my-saas |
+--------------------------------------------------+
| Score     [##################..]  91/100  (^_^)  |
| Trend     -==#=##=##  last 10  up                |
| Due       native search check in 4 days          |
| Pending   2 outcomes to check                    |
| Learned   1. [outcome] use plain fetch           |
|           2. [user] keeps Postgres               |
| Models    suggest - easy haiku - hard opus       |
| Rules     4 yours - 12 reuse - 3 decisions       |
+--------------------------------------------------+
Say: "forget 2" - "confirm 1" - "sancode setup" - "sancode visual card"
```

Everything SanCode learned about you is visible, and you can delete or confirm any lesson.

### The brain file

One Markdown file, `.sancode/brain.md`, about 120 lines at most. Its first line holds the SanCode version, so it upgrades itself after an update. It cleans itself up: merges duplicates, drops old decisions, never touches your rules.

```markdown
## Profile      what you're building, stage, stack, existing deps
## Settings     strictness, way of working, council, visual
## Rules        your non-negotiables and always/never rules
## Reuse        format a date → lib/format.ts:formatDate
## Decisions    2026-10-27 | Native search | kill-switch: p95 > 300ms by 2026-12-01 | open
## Lessons      [user] keeps Postgres · [outcome] use plain fetch
## Scores       2026-10-27 | add search | 89 | coding | files: search.ts | outcome: kept
```

Commit it to share with your team, or ignore it to keep it personal.

## Modes

### Coding Mode (default)

Before writing code: does this already exist? Can I reuse it, simplify it, remove it? Will users care or pay? Can it launch today?

- Delete before create
- Native before package (say why native is worse before adding one)
- One file before many, no `utils/`, `services/`, `managers/`, `core/` for one helper
- Direct before abstract
- Don't automate something that happened once

### Startup Mode

Say "startup mode", or SanCode switches to it when a feature's value is unproven.

- Can this be validated manually this week?
- Can it be sold before it is built?
- Can a landing page, form, spreadsheet, or email do the job?
- Is a customer waiting for it, by name?

Returns **BUILD**, **VALIDATE FIRST**, or **DON'T BUILD**, plus one step doable in under 48 hours. Many "technical tasks" are fear or fake progress wearing a hoodie. "This should not be built yet" is a feature.

### Work Mode

SanCode for everything that isn't code: documents, plans, research, spreadsheets, decks, emails. It's the default for non-code tasks in chat and Cowork.

- **Answer first**: the result in the first lines, detail after
- **One output before many**: one page before a deck, one sheet before a dashboard
- **Reuse before create**: update the existing doc or template
- **No tools for one-time jobs**: no new app, subscription, or automation for something done once
- **Cut what nobody reads**: no filler intros or repeated summaries

Its SanScore counts extra deliverables, new tools, and words beyond what the job needed, and gives points back for reusing an existing doc.

### Council Mode

Startup Mode asks *whether* to build. Council Mode decides *how* at a real fork: a new dependency, new infrastructure, a rewrite, build vs buy, ship vs polish. Say "council mode", or SanCode convenes it before acting. Never for routine edits or bug fixes, and never twice for the same question.

Six seats speak in order, three lines each:

| Seat | Asks |
|---|---|
| Customer | What breaks for a user without this? |
| CFO | Hours to build and to maintain? |
| CTO | Thinnest version that proves the risky part? |
| Maintainer | Who debugs this in 6 months? |
| Chief Risk | The 90-day post-mortem, written now |
| Lead | Decides last, says why |

They vote SHIP / SIMPLIFY / KILL / DEFER. The result is one decision, a kill-switch that reverses it, and a first move. The decision is saved to the brain. For business calls (pricing, hiring, pivots), use the full Council skill.

### Model Routing

SanCode rates every task **easy**, **normal**, or **hard**, and matches the model to it: cheap and fast for a typo, the strongest model for a migration or a bug with an unknown cause.

| Rating | Examples | Claude Code | Codex |
|---|---|---|---|
| easy | typo, rename, config value, one small edit | `haiku` | profile `sancode-easy` |
| normal | feature or fix in existing patterns | `sonnet` | your default |
| hard | unknown bug, many files, migration, security, architecture, council | `opus` | profile `sancode-hard` |

| Setting | What happens |
|---|---|
| **suggest** (default) | One line when the model doesn't fit, e.g. `Hard task. Stronger model: /model opus`. Never nags: once per direction per session. |
| **auto** | Claude Code hands the hard part (diagnosis, plan, council) to an `opus` subagent, and bulk mechanical work to a `haiku` subagent. Codex, Claude chat, and Cowork can't switch models mid-task, so they fall back to suggest (in chat: "pick Opus in the model picker"). |
| **off** | No ratings, no suggestions. |

Change it with `sancode models auto`, or the tiers with `sancode models hard=opus easy=haiku`. If you ignore the same suggestion three times, SanCode stops making it.

Codex profiles for the suggestions, in `~/.codex/config.toml`:

```toml
[profiles.sancode-easy]
model_reasoning_effort = "low"
# model = "<your fast model>"

[profiles.sancode-hard]
model_reasoning_effort = "high"
# model = "<your strongest model>"
```

### Infrastructure Mode

Built into every mode. SQLite before Postgres. One server before microservices. Cron before queues. Files before object storage. In-memory before Redis. No Redis, Kubernetes, queues, or workers until current usage proves the need.

## SanScore

Every task ends with a score out of 100. Higher means simpler. In a git repo it is **measured**, not guessed:

| Added | Points |
|---|---|
| Each package | −10 |
| Each new file | −5 |
| Every 20 lines added | −1 (max −20) |
| Every 20 lines deleted | +1 (max +10) |
| Complexity low / medium / high | −5 / −15 / −30 |
| Each piece of infrastructure | −15 |

### The recap box

Every task ends with one closed box, 52 characters wide, plain ASCII, so it lines up in any terminal or chat. Pick what goes inside at setup, or say `sancode visual bar`, `card`, or `off`.

**bar** (default): a score bar and a face.

```text
+--------------------------------------------------+
| SanCode recap                    v2.4 - measured |
+--------------------------------------------------+
| Score     [#################...]  89/100  (-_-)  |
| Mode      coding                                 |
| Task      normal - opus (current)                |
| Packages  0                                      |
| Files     +1                                     |
| Lines     +34 / -0                               |
| Complex   low                                    |
| Infra     none                                   |
| Trend     72 > 81 > 85 > 89  up                  |
| Brain     reuse +1                               |
+--------------------------------------------------+
```

**card**: every factor gets its own bar. Full means nothing was added.

```text
+--------------------------------------------------+
| SanCode recap                    v2.4 - measured |
+--------------------------------------------------+
| Score     [#################...]  89/100  (-_-)  |
| Mode      coding                                 |
| Task      hard - opus (delegated)                |
| Packages  [##########]  0                        |
| Files     [#########.]  +1                       |
| Lines     [#########.]  +34 / -0                 |
| Complex   [########..]  low                      |
| Infra     [##########]  none                     |
| Trend     72 > 81 > 85 > 89  up                  |
| Brain     reuse +1                               |
+--------------------------------------------------+
```

**off**: the same box, numbers only. In Work Mode the rows become Output, Tools, and Reused.

Faces: `(^_^)` 90+, `(-_-)` 70–89, `(o_o)` 50–69, `(x_x)` below 50. The status screen and council votes use the same box:

```text
+--------------------------------------------------+
| SanCode council               KILL wins - 4 of 6 |
+--------------------------------------------------+
| SHIP      #         1                            |
| SIMPLIFY  #         1                            |
| KILL      ####      4                            |
| DEFER               0                            |
+--------------------------------------------------+
```

## Commands

| Say | Does |
|---|---|
| `sancode status` | Home screen: score, trend, due decisions, what it learned |
| `forget N` / `confirm N` | Delete or confirm a lesson from the home screen |
| `sancode setup` | Rerun setup, change preset, rules, and settings |
| `startup mode` / `sancode startup` | Should this be built at all? |
| `council mode` / `sancode council` | Convene the council on the current fork |
| `sancode code` | Force Coding Mode |
| `sancode visual bar` / `card` / `off` | Change the score visual |
| `sancode models suggest` / `auto` / `off` | Model routing by task difficulty |
| `sancode models hard=opus easy=haiku` | Change the model tiers |

## Principles

1. Delete before create
2. Native before package
3. Simple before abstract
4. Single file before architecture
5. Working before perfect
6. Ship before optimize
7. Revenue before scale
8. Users before infrastructure

## What SanCode Fights

| Against | For |
|---|---|
| Installing a package for one function | Small diffs |
| Services before there are users | Native platform features |
| Splitting tiny features into fake architecture | Boring code |
| Admin dashboards before revenue | Revenue pressure |
| Queues, caches, and workers for imaginary scale | Single-server thinking |
| Generalized code for one known use case | Customer proof |
| Refactoring code customers haven't validated | Shipping today |

## Examples

`examples/` compares **AI Slop Solution vs SanCode Solution** for:

- Date picker and CSV processing
- Search and authentication
- Dashboard

## The Rule

Before you ask an AI agent to build, ask it to remove.

Before you ask it to architect, ask it to ship.

Before you ask it to scale, ask whether anyone cares.
