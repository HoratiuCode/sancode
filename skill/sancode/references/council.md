# SanCode Council

Seats are paid to disagree. Play them hard, not politely. The whole council fits on one screen.

## 1. Frame (1 line)

Restate the fork as a binary or ranked choice. Add: reversible or one-way door, and cost of being wrong.
If it isn't decidable, say so and stop.

## 2. Seats

Speak in this order (the Lead never speaks first, it anchors the room). Max 3 lines each:
position, strongest reason, the one fact that would flip them.

1. **Customer** (empty chair): what breaks in a user's week if this doesn't exist? Kills anything vitamin-shaped.
2. **CFO**: founder hours are the scarcest currency. Hours to build, hours to maintain, payback.
3. **CTO**: the thinnest version that proves the risky part. Hates rewrites, loves throwaway spikes.
4. **Maintainer**: who debugs this in 6 months at 2am? Counts new files, packages, and concepts.
5. **Chief Risk**: write the post-mortem as if it failed in 90 days, one paragraph. Mandatory. Veto on one-way doors only.
6. **Lead**: synthesizes and decides. May overrule the vote, must say why.

Small decision: cut to Customer, CFO, Lead.

## 3. Vote

Each seat: SHIP / SIMPLIFY / KILL / DEFER, confidence 1-5. Report the tally.

Draw the tally in the same 52-character box as the recap (see The box in SKILL.md), one `#` per vote, winner and count in the header:

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

Quote dissent, never average it away. DEFER needs a date, otherwise it's a KILL in a costume.

## 4. Decision

- **Decision:** one sentence
- **Because:** max 3 bullets
- **Kill-switch:** the signal or metric + date that reverses this
- **First move:** doable now
- **Not doing:** what this decision rules out

## 5. Record

Append one line to `## Decisions` in `.sancode/brain.md`:

```text
- YYYY-MM-DD | <decision> | kill-switch: <signal> by YYYY-MM-DD | status: open
```

Next time the same fork comes up, cite this line instead of re-convening, unless the kill-switch fired.

## Rules

- If every seat agrees, the framing is wrong. Reframe once.
- Every seat names a falsifier, or its opinion is struck.
- Don't invent numbers. Missing data becomes the first move.
- For business decisions (pricing, hiring, pivots, killing an idea), use the full `council` skill if installed.
