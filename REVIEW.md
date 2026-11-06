# SanCode — Weekly Review Brief

This file is the **standing context** for the weekly review cron job
(`sancode weekly review`, job `bb9864c35820`). It runs every Monday 09:00 EET
and posts a review of this project to the chat.

The agent reads THIS file at the start of every run. Anything you add here
becomes a binding instruction for the review. Edit it freely — no code needed.

---

## Standing focus (what to prioritize)
<!-- e.g. "prioritize performance, deploy-safety, and accessibility" -->
<!-- leave blank for a balanced default review -->

## Do NOT touch / ignore (skip entirely)
<!-- paths, files, or topics the review must never flag or touch -->
- `landingpage/` — known dead duplicate, excluded from deploy; tracked separately

## Known issues / false positives (do not re-flag)
<!-- things the review already knows about, so it stops re-reporting them -->
<!-- e.g. "the WebGL noise overlay is intentional, leave it" -->

## Hard rules
<!-- extra constraints the agent must follow -->
- Recommendation-only: the agent never edits files or generates large new code.
- It suggests concise, prioritized fixes and cites file names / line numbers.
