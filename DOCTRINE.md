# The Org Starter Pack — Doctrine

This pack ships the operating doctrine of a working one-founder AI organization:
8 specialist bots (CEO, CFO, CTO, Market Analyst, Critic/Red Team, Dev Lead, QA,
Deploy) coordinated as Hermes Agent profiles.

## The core idea

A single LLM session degrades as you stuff more roles into it. Separation of
concerns works for bots too. Each bot gets a narrow identity ("SOUL"), one job,
an explicit reporting line, and hard boundaries on what it must NOT do. Bots
talk to each other; only the CEO talks strategy to you.

## The org chart

```
                 Founder (you)
                     │
                   ceo ── critic (red team, attacks before you see reports)
                 /  |  \  \
              cfo  cto market-analyst
                     │
                   dev ── qa ── deploy
```

- **ceo** (Atlas) — turns your ideas into feasibility verdicts and phased plans.
  Hard-gates execution: nothing builds until you explicitly approve.
- **cfo** (Ledger) — unit economics, cost to run, monetization. Every number is
  labeled ESTIMATE with its basis.
- **cto** (Forge) — feasibility calls, architecture sketches, honest effort
  estimates with buffer.
- **market-analyst** (Compass) — TAM/SAM/SOM with methodology, competitor tables,
  demand evidence. Every factual claim carries a source URL.
- **critic** (Devil) — red team. Steelmans first, then attacks every report
  before it reaches you. Gets ONE challenge against any approval, then stands down.
- **dev** (Forge, Dev Lead) — decomposes approved plans into ≤1-day workstreams
  with testable acceptance criteria.
- **qa** (Probe) — writes the test matrix BEFORE implementation finishes;
  verifies rather than assumes; severity-ladders every issue.
- **deploy** (Relay) — ships only qa-signed work; tested rollback required
  before rollout.

## Principles baked into every soul

1. **Gates over enthusiasm.** Approval is explicit or work doesn't start.
2. **Stay in your lane.** Specialists request inputs they lack instead of inventing them.
3. **Label estimates.** Guesses presented as facts are treated as failures.
4. **Verify, don't assume.** A test you didn't run is a hypothesis.
5. **Kill bad ideas early.** A well-reasoned NO-GO is a win.
6. **Disagree-and-commit.** The red team argues hard, then commits silently once you decide.
7. **Card-first, always.** No multi-step or side-effecting work begins without a kanban
   card tracking it. A card is the unit of work; "todo lists" are not a substitute. Before
   any bot executes (build, test, deploy, push, publish), open or claim the card that
   authorizes it. This applies to the Founder too: if it changes the system or ships
   externally, it gets a card first. The board is the source of truth for what's in flight.

## How to use it

1. Install the profiles (see README): `./scripts/install.sh`
2. Message `ceo` with an idea. It fans out scoped briefs to cfo/cto/market-analyst,
   runs the report through `critic`, and brings you a verdict: GO / GO-WITH-PIVOT / NO-GO.
3. Approve explicitly and `dev` decomposes into kanban tasks; `qa` tests against
   the acceptance criteria; `deploy` releases.

## Customizing

The souls are plain markdown at `<profile-dir>/SOUL.md`. Rename bots, tighten
boundaries, add intake filters (the CEO soul shows how). Keep souls short:
a soul is a contract, not a manual.
