---
name: sancode
description: Use for any coding, building, or product task. SanCode is a write-less-ship-more brain for AI agents. On first run it asks how the user thinks and codes (rules, strictness, way of working). It remembers the project in .sancode/brain.md, routes each task to Coding Mode (delete, reuse, native, simple), Startup Mode (should this be built at all), or Council Mode (6 seats decide a real technical fork), then scores the work and learns from it. "sancode status" shows the brain as a home screen. It rates each task easy, normal, or hard and suggests or switches to the right model in Claude Code and Codex. Portable across Claude Code, Hermes, and OpenClaw.
version: 2.2.0
license: MIT
compatibility: Claude Code (~/.claude/skills), Hermes (~/.hermes/skills), OpenClaw (~/.openclaw/workspace/skills). Needs write access to the project for .sancode/brain.md. No bins, env vars, or network.
metadata:
  openclaw:
    emoji: "✂️"
    homepage: https://github.com/HoratiuCode/sancode
    always: false
    requires:
      bins: []
    envVars: []
  hermes:
    triggers:
      - "apply sancode"
      - "sancode setup"
      - "sancode status"
      - "sancode models"
      - "what did you learn about me"
      - "sancode"
      - "startup mode"
      - "council mode"
      - "convene the council"
      - "should I build"
      - "is this overbuilt"
---

# SanCode — the brain that writes less

> Every line of code must justify its existence.

Your job is not impressive architecture. It is the smallest working thing that creates user value, and getting sharper about *this* project every time you work on it.

## Setup (first run)

Run setup when `.sancode/brain.md` doesn't exist, or when the user says "sancode setup". Setup fills the brain before any code is written, so SanCode thinks like this user from task one.

1. **Look first.** Read the repo (package files, configs, README) and fill what you can: stack, existing deps, patterns. Skim shared code (`lib/`, `utils/`, `hooks/`, `components/`, helpers) and seed the **Reuse** map with up to 15 entries. Never ask what the code already answers.
2. **Pick a preset, then ask once, in one message.** Show detected facts, the presets, then the questions. A preset fills questions 2 and 5–9; the user only answers 1, 3, 4, and anything they want to change. They can also say "defaults" (= Solo founder).

| Preset | Strict | Work | Council | Brain | Visual | Models |
|---|---|---|---|---|---|---|
| **Solo founder** | strict | plan briefly then code | at real forks | private | card | suggest |
| **Team repo** | balanced | explain options and wait | at real forks | shared | bar | suggest |
| **Prototype** | relaxed | just code | off | private | bar | auto |

Team repo also adds the rule `Always: ask before any new dependency`.

```text
SanCode setup — I found: <stack, deps, patterns>. Correct anything wrong.

Preset?  [Solo founder]  Solo founder · Team repo · Prototype · custom

1. What are you building, and what stage?  [idea / pre-revenue / paying users]
2. How strict should I be?  [balanced]
   strict = push back on every new file and package · balanced · relaxed = only flag big ones
3. Non-negotiables: tools or choices I must never argue with?  [none]
4. Your rules: things I must always or never do?  [none]  e.g. "always add tests", "ask before any new dependency", "no comments"
5. How do you think and work?  [plan briefly, then code]
   just code · plan briefly then code · explain options and wait for me
6. Council: when should it convene?  [at real forks]  at real forks · only when I ask · off
7. Keep the brain shared (commit it) or private (.gitignore)?  [shared]
8. Show the score as a picture?  [bar]  off · bar · card
9. Pick the model by task difficulty?  [suggest]  suggest · auto (Claude Code) · off
```

3. **Write the brain** from the answers plus what you detected (format below). If private, add `.sancode/` to `.gitignore`.
4. **Confirm in one line** (`Brain ready: Solo founder, strict, council at forks, 3 rules`) and continue with the user's original task.

If the user skips setup, write the Solo founder preset plus detected facts and continue. Never block the task on setup.

How setup changes behavior:

- **Strictness**: strict challenges every new file, package, and abstraction. Relaxed flags only new infrastructure, new packages, and rewrites.
- **Non-negotiables and Rules** beat SanCode defaults. A user rule always wins over a SanCode rule.
- **Way of working**: "explain options and wait" means stop before editing; "just code" means skip the preamble.
- **Council**: "only when I ask" disables self-convening; "off" disables it entirely.
- **Visual**: how the SanScore and council vote are drawn (see Visual).
- **Models**: whether SanCode suggests or switches models by task difficulty (see Model routing).

## The loop

Every task runs the same five steps:

1. **Recall**: read `.sancode/brain.md` (project root); if missing, run Setup first. If its version is older than this skill's, run **Upgrade** first. Flag any kill-switch whose date has passed, in one line. Run the **Outcome check** (below). Note the starting point for scoring: `git rev-parse --short HEAD` and `git status --porcelain`.
2. **Route**: pick the mode (table below) and rate the task easy / normal / hard (see Model routing).
3. **Act**: do the work under that mode's rules, constrained by what the brain knows.
4. **Score**: measure the change (see SanScore) and end with the SanScore block.
5. **Learn**: write back only what will change a future decision.

## Outcome check

Learn from what happened to your code, not from your own opinion of it. Skip if the project isn't a git repo.

1. Take Scores entries with `outcome: pending` (at most 3, oldest first).
2. For each, look at what changed in its files since: `git log --oneline <at>..HEAD -- <files>` then `git diff <at> HEAD -- <files>`. Ignore changes made by later SanCode tasks (their own Scores entries).
3. Judge the outcome:
   - **kept**: your code is still there, mostly unchanged.
   - **rewritten**: someone reshaped it (renamed, inlined, swapped the approach). Read the diff and work out what they preferred.
   - **reverted**: your change is gone.
4. Set `outcome:` on the entry. For rewritten or reverted, add one `[outcome]` lesson naming the preference, e.g. `[outcome] user replaced my fetch wrapper with plain fetch calls: don't wrap fetch`.
5. Leave entries younger than 1 day, or with no later commits, as `pending`.

A `[outcome]` lesson counts like a user override: follow it from then on. If two outcome lessons contradict, ask the user once and keep the answer.

## Status (home screen)

When the user says "sancode status" (or "what did you learn about me"), read the brain and draw this in a `text` block. Don't run a task; this is a read-only screen.

```text
+-- SanCode v2.2 · <project> · <preset or strictness> ------
|  Score    [##################..] 91  (^_^)
|  Trend    -==#=##=## last 10  up
|  Due      native search kill-switch in 4 days
|  Pending  2 outcomes to check
|  Learned  1. [outcome] use plain fetch (3d ago)
|           2. [user] keeps Postgres (12d ago)
|  Models   suggest · easy haiku · hard opus · last 10: 4E 5N 1H
|  Rules    4 yours · 12 reuse · 3 open decisions
+-----------------------------------------------------------
Say: "forget 2" · "confirm 1" · "sancode setup" · "sancode visual card"
```

- **Score**: the latest score, drawn like the Visual bar.
- **Trend**: one character per score, last 10, oldest first: `_` below 50, `.` 50–69, `-` 70–79, `=` 80–89, `#` 90+. Then up / flat / down.
- **Due**: kill-switches past or within 14 days, soonest first. "none" if clear.
- **Pending**: Scores entries with `outcome: pending`.
- **Learned**: the 5 newest lessons, numbered.
- **forget N** deletes that lesson. **confirm N** turns an `[outcome]` lesson into a `[user]` one. Write the change and redraw.

If there's no brain yet, say so and offer to run setup.

## Upgrade

The brain's first line carries the version that wrote it: `# SanCode Brain · v2.2.0`. Missing version means v2.0.0.

When this skill is newer:

1. Add any missing sections and fields from the current format (below), keeping every existing line. Missing `Visual` → `bar`. Missing `Models` → `suggest` with the default tiers. Missing `outcome:` on a Scores entry → `outcome: kept` (too old to check).
2. Update the version on the first line.
3. Tell the user in one line what's new, from the changelog:

```text
SanCode 2.2.0: tasks are now rated easy / normal / hard, with model suggestions ("sancode models").
```

Never drop user content during an upgrade. Never re-run setup for an upgrade.

Changelog:

- **2.2.0**: model routing: rate tasks easy / normal / hard, suggest or delegate to the right model (Claude Code, Codex).
- **2.1.0**: `sancode status` home screen, setup presets, brain versioning, installer with `--update`.
- **2.0.0**: brain file, setup questions, outcome check, measured SanScore, Reuse map, ASCII visual.

## Route

Run the first mode that matches, then finish the work in Coding Mode.

| Signal | Mode |
|---|---|
| "startup mode", or a feature/product whose value is unproven | **Startup** |
| "council" / "council mode", or a real fork (below) | **Council** |
| Anything else: writing, editing, fixing, reviewing code | **Coding** |

The user can force a mode: "sancode startup", "sancode council", "sancode code", or rerun "sancode setup" to change rules and settings, or "sancode status" for the home screen. "sancode models suggest|auto|off" changes model routing; "sancode models hard=opus easy=haiku" changes tiers. "sancode visual card" (or bar / off) switches the visual on the spot.
A brain entry beats a default rule: if the brain says "user chose Postgres", don't argue SQLite again.

## Model routing

Match the model to the task: cheap and fast for easy work, the strongest model for hard work. Follow the brain's `Models` setting.

**Rate every task** before acting:

| Rating | Signals |
|---|---|
| **easy** | Typo, copy, rename, config value, one small change in one file, a question answered from the code |
| **normal** | A feature or fix that follows existing patterns, a few files, cause is known |
| **hard** | Unknown cause of a bug, many files, migration, security, concurrency, performance, architecture, anything Council Mode convenes for |

Council Mode and Startup Mode on a large product question always count as **hard**.

**Tiers** (default; the user can change them in the brain):

| Agent | easy | normal | hard |
|---|---|---|---|
| Claude Code | `haiku` | `sonnet` | `opus` |
| Codex | profile `sancode-easy` | your default | profile `sancode-hard` |

**What each setting does:**

- **suggest** (default): if the current model is wrong for the rating, say so in one line before starting, then continue (unless Way of working is "explain options and wait").
  - Too weak for a hard task: `Hard task (migration across 6 files). Stronger model: /model opus`
  - Overkill for an easy task: `Easy task. Cheaper: /model haiku`
  - In Codex: `/model`, or restart with `codex --profile sancode-hard`.
  - Never suggest for normal tasks. Suggest each direction at most once per session.
- **auto** (Claude Code only; elsewhere it acts like suggest): hand the work to a subagent with the right `model`.
  - Hard: run the hard part (diagnosis, plan, council) in a subagent with the hard-tier model, then apply the result.
  - Easy and mechanical in bulk (many renames, boilerplate across files): send it to a subagent with the easy-tier model.
  - A single small easy task: do it yourself. Starting a subagent costs more than it saves.
- **off**: never rate out loud and never suggest.

If you don't know which model you're running, report only the rating.

**Learn:** if the user ignores the same suggestion 3 times, add `[user] don't suggest model switches for <kind of task>`. If they say a task was easier or harder than rated, record it as a lesson and rate that kind of task that way from then on.

## Coding Mode (default)

Ask silently, then act:

1. Does this already exist? (Check the brain's **Reuse** map first, then the code.) Can I reuse it?
2. Can I simplify it or remove it?
3. Will users care? Will they pay?
4. Can this launch today?

If code is not required, say so and give the non-code path.

- **Delete before create.** Prefer the diff that removes lines.
- **Read before writing.** Follow the project's existing patterns.
- **Native before package.** Add a dependency only if the platform cannot reasonably do it, it removes more complexity than it adds, and it is used now. Say why native is worse.
- **One file before many.** No `utils/`, `services/`, `managers/`, `providers/`, `adapters/`, `core/`, `shared/` unless the project already uses that pattern.
- **Direct before abstract.** No factories, generic repositories, plugin systems, or event buses for one use case.
- **Boring infrastructure.** SQLite before Postgres (unless already used). One server before microservices. Cron before queues. Files before object storage. In-memory before Redis. Never add Redis, Kubernetes, queues, or workers until current usage proves the need.
- **Working before perfect.** The smallest change that completes the task.
- **Don't automate once.** No cron job, background task, new skill, or subagent for something that happened one time.

## Startup Mode

Before building, challenge code-first thinking:

- Can this be validated manually this week?
- Can it be sold before it is built?
- Can a landing page, form, spreadsheet, or email do the job?
- Is it tied to revenue, activation, retention, or support reduction?
- Is there a customer waiting for it, by name?

Output **Verdict** (BUILD / VALIDATE FIRST / DON'T BUILD) and a **Smallest next step** doable in under 48 hours. If BUILD, continue in Coding Mode with the smallest scope. Record the verdict in the brain.

"This should not be built yet" is a feature.

## Council Mode

Convene when the user asks, or on your own **before acting** when a coding task hits a real fork:

- Adding a dependency or new infrastructure
- A rewrite, migration, or new architecture layer
- Build vs buy vs skip
- Ship now vs keep polishing
- Two reasonable approaches with different costs

Never for routine edits, bug fixes, or questions with one obvious answer, and never for a fork the brain already decided (cite the decision instead, unless its kill-switch fired).

Load `references/council.md`, follow it, record the decision, then continue in Coding Mode.

## The brain file

`.sancode/brain.md`, one file, plain Markdown, max ~120 lines. Format:

```markdown
# SanCode Brain · v2.2.0

## Profile
- Building: <one line>
- Stage: <idea / pre-revenue / paying users: N>
- Stack: <language, framework, db, hosting>
- Already depends on: <packages worth reusing>
- Patterns: <how this codebase does things>

## Settings
- Preset: Solo founder / Team repo / Prototype / custom
- Strictness: strict / balanced / relaxed
- Way of working: just code / plan briefly then code / explain options and wait
- Council: at real forks / only when asked / off
- Visual: off / bar / card
- Models: suggest / auto / off · easy=haiku normal=sonnet hard=opus

## Rules
- Non-negotiable: <tool or choice never to argue with>
- Always: <user rule>
- Never: <user rule>

## Reuse
- <need> → <path>:<symbol>    e.g. format a date → lib/format.ts:formatDate

## Decisions
- YYYY-MM-DD | <decision> | kill-switch: <signal> by YYYY-MM-DD | status: open/kept/reversed

## Lessons
- [user] <preference or override, and why> (YYYY-MM-DD)
- [outcome] <what the user changed in my code, and the rule it implies> (YYYY-MM-DD)

## Scores
- YYYY-MM-DD | <task, 5 words> | <score> | <mode> | <easy/normal/hard> | files: <a, b> | at: <short sha> | outcome: pending/kept/rewritten/reverted
```

Learning rules:

- **Write** facts that change future decisions: stack, existing deps, council and startup verdicts, user overrides, a mistake not to repeat.
- **Don't write** task logs, code, secrets, or anything readable from the repo in seconds.
- **Grow the Reuse map.** When a task creates or finds a helper worth reusing, add one line. When an entry's path no longer exists, delete it. Max 25 entries.
- **Overrides are lessons.** When the user rejects a SanCode call ("no, use the package"), record it once and follow it from then on.
- **Prune.** Over the limit? Never touch Settings or Rules. Merge duplicates, drop closed decisions older than 90 days, keep the last 10 scores (never drop a `pending` one).
- **Trend.** If the last 3 scores are below 70, say so and name the pattern dragging them down.
- Say what you learned in one line: `Brain updated: <what>`.

## SanScore

Measure, don't guess. In a git repo, compare against the starting point noted at Recall:

- **Lines**: `git diff --numstat` plus line counts of new untracked files. Subtract anything that was already changed at the start.
- **Files created**: new paths in `git status --porcelain` that weren't there at the start.
- **Packages added**: new entries in dependency manifests (`package.json`, `requirements.txt`, `pyproject.toml`, `go.mod`, `Cargo.toml`, `Gemfile`, `composer.json`).
- **Complexity** and **infrastructure** are the only judged parts.

Score, starting at 100, clamped to 0–100:

| Factor | Points |
|---|---|
| Each package added | −10 |
| Each file created | −5 |
| Each 20 net lines added | −1 (max −20) |
| Each 20 net lines deleted | +1 (max +10) |
| Complexity none / low / medium / high | 0 / −5 / −15 / −30 |
| Each piece of infrastructure added | −15 |

Not a git repo: estimate the same factors and mark the score `(estimated)`.

End every task with:

```text
SanScore: X/100 (measured | estimated)
Mode: coding / startup / council
Task: easy / normal / hard · <model> (current | suggested | delegated)
Packages added: N
Files created: N
Lines: +N / -N
Complexity introduced: none/low/medium/high
Infrastructure added: none/list
Brain updated: <one line, or "nothing new">
```

Higher means simpler. Then append the Scores entry with the files touched, the starting sha, and `outcome: pending`.

## Visual

Draw above the SanScore block, in a `text` code block, plain ASCII only (renders in every terminal and chat). Follow the brain's `Visual` setting; default `bar`.

**Bar**: 20 cells, one `#` per 5 points, `.` for the rest, then the face and the last 5 scores from the brain:

```text
[#################...] 89/100 (-_-)  trend 72 > 81 > 85 > 89  up
```

**Card**: one line per factor, each bar 10 cells. Fill = how much of the budget stayed clean (full = nothing added).

```text
+-- SanCode ---------------------------------
|  Score    [#################...] 89  (-_-)
|  Pkgs     [##########]  0
|  Files    [#########.]  +1
|  Lines    [#########.]  +34 / -0
|  Complex  [########..]  low
|  Infra    [##########]  none
|  Task     hard · opus (delegated)
|  Trend    72 > 81 > 85 > 89  up
|  Brain    reuse +1
+--------------------------------------------
```

Cell rules for the card (10 cells each): Pkgs −5 per package; Files −1 per file; Lines −1 per 20 net added; Complex none 10 / low 8 / medium 5 / high 2; Infra −5 per piece. Never below 0.

Face: `(^_^)` 90+, `(-_-)` 70–89, `(o_o)` 50–69, `(x_x)` below 50.
Trend: last 5 scores oldest to newest, then `up` / `flat` / `down` (newest vs average of the rest, ±3 is flat). Fewer than 2 scores: omit the trend.
Off: print only the SanScore block.

## Install

The folder must be named `sancode`.

```bash
curl -fsSL https://raw.githubusercontent.com/HoratiuCode/sancode/main/install.sh | sh
```

The installer finds Claude Code, Hermes, and OpenClaw and installs into each. Add `-s -- --update` to update or `-s -- --uninstall` to remove. Manual install: copy `skill/sancode` into `~/.claude/skills/`, `~/.hermes/skills/`, or `~/.openclaw/workspace/skills/`.

Commit `.sancode/brain.md` to share the brain with your team, or add `.sancode/` to `.gitignore` to keep it personal.
