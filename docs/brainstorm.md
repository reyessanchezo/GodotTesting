# Brainstorm — Candidate Directions

> **Status:** Raw notes — being iterated on by two devs
> **Last Updated:** 2026-11-09
>
> Purpose: capture candidate game directions before we pick one. Selection gets logged in `gdd.md` → Decision Log. Keep ideas verbatim for now; polish only when one starts winning.

## Idea 1 — Retro Souls-like (small scale)

- Retro-style, small-scale souls-like.
- Designed for **10 somewhat interconnected areas**.
- (Implication: 2D, tight arena-like spaces, permadeath/punishment loops, interconnected map — not open world.)

## Idea 2 — Fantasy Top-Down RTS with Procedural World

- Top-down RTS, references: **Riftbreaker / Factorio**, fantasy setting.
- **You pick different monster races** (minotaur, merlock, etc.).
- Build up your place; the **world procedurally generates** resources, nodes, caves around you.
- Towns, dungeons, people, monsters — **persuade them to join or destroy them**.
- **Diplomacy is reactive:** other parties respond to your diplomacy actions.

## Idea 3 — "Dream Game": Customization-First ARPG

- Open world, **Outward-scale**.
- **Customization is the focus.**
- **Absolver-style combat mechanics.**
- Two class routes:
  - **Marshall** — learn new moves à la Absolver.
  - **Mystic** — Orators (words / power words) set up chants that cause effects; Scribes write runes in the air; or enchanted gear inscribed with runes.
- **Third magic mechanism:** simple, fast, but **strains the fabric of the universe** — i.e. bending the world to your will.
- 3rd person perspective.

## Tensions with Current Constraints (AGENTS.md)

| Idea | Conflict with current scope rules |
|------|-----------------------------------|
| 1 | 10 areas vs. "one small area" MVP — but each area can be an MVP-sized unit; closest fit to the current pipeline |
| 2 | Procedural gen + diplomacy + RTS systems = multiple simultaneous systems; directly against "prove one system at a time" and "no complex physics/open world" |
| 3 | 3D + open world are both explicitly listed under "What to Avoid"; Absolver-style combat + 3 magic systems is the largest scope of the three |

Note: these are constraints for **iteration discipline** (one system at a time), not hard bans on the final game. If we pick Idea 3, the GDD's Scope Limits section and AGENTS.md's "What to Avoid" list need to be rewritten together — that's a deliberate decision gate, not a silent edit.

## Open Questions

- [ ] Which idea do we both actually want to play? (Vote, not argue.)
- [ ] If 1: what's the one combat verb that must feel great in a 5-minute test?
- [ ] If 2: is the core loop *build* or *diplomacy*? Only one can be the MVP core.
- [ ] If 3: 3rd-person + 2D engine is a hard engine constraint — do we commit to the Godot .NET 3D path or stay 2D?
- [ ] Solo-dev time budget per week (drives which scope is even real)?

## Decision Log

| Date | Decision | Rationale |
|------|----------|-----------|
| | | |
