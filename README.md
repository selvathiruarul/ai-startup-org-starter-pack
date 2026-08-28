# AI Startup Org Starter Pack

A working **one-founder AI organization** as Hermes Agent profiles — 8 specialist bots
(CEO, CFO, CTO, Market Analyst, Critic/Red Team, Dev Lead, QA, Deploy) you can install
in one command and start pitching ideas to.

This is not a chatbot. It's an operating system for turning founder ideas into rigorous
feasibility verdicts and phased execution plans — with a red-team bot that attacks every
report before you see it, and a hard gate so **nothing executes until you explicitly approve**.

## What you get

| File | Purpose |
|------|---------|
| `souls/ceo.md` | Atlas — turns ideas into verdicts + plans; gates execution |
| `souls/cfo.md` | Ledger — unit economics, cost, monetization |
| `souls/cto.md` | Forge — technical feasibility, effort, architecture |
| `souls/market-analyst.md` | Compass — TAM/SAM/SOM, competitors, demand evidence |
| `souls/critic.md` | Devil — red team; attacks reports before you read them |
| `souls/dev.md` | Forge (Dev Lead) — decomposes approved plans into tasks |
| `souls/qa.md` | Probe — test matrix + verification gate |
| `souls/deploy.md` | Relay — ships only qa-signed, rollback-ready work |
| `DOCTRINE.md` | The org's operating principles + how to use it |
| `scripts/install.sh` | One-command installer (version-pinned to Hermes ≥0.20) |

## Install

```bash
./scripts/install.sh          # install all 8 profiles
# or a subset:
./scripts/install.sh ceo qa
```

Requires the [Hermes Agent](https://hermes-agent.nousresearch.com/docs) CLI on your PATH.

## Use it

```bash
hermes -p ceo chat -q "Idea: a micro-SaaS that does X"
```

Atlas fans out to CFO/CTO/Market-Analyst, runs the report through Devil (critic), and
brings you a verdict: **GO / GO-WITH-PIVOT / NO-GO**. Approve explicitly and the org
decomposes the work, tests it, and ships it — card by card, on your kanban board.

## Customizing

Souls are plain markdown at `<profile-dir>/SOUL.md`. Rename bots, tighten boundaries,
add intake filters. Keep souls short: a soul is a contract, not a manual.

> This pack is the free tier. The full doctrine + installer walkthrough + updates tier
> is available as a paid add-on.
