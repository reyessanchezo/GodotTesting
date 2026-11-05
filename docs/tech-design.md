# Technical Design — [Game Title]

> **Status:** [Draft / In Review / Approved / Superseded]
> **Last Updated:** YYYY-MM-DD

## Architecture Overview

> [High-level description of the game's technical architecture. What are the main systems? How do they communicate?]

## Scene Tree Design

> [Describe the top-level scene hierarchy. Example:]
>
> ```
> Main (Node2D)
> ├── World (Node2D)
> │   ├── Player (CharacterBody2D)
> │   └── Enemies (Node2D)
> ├── UI (CanvasLayer)
> │   ├── HUD (Control)
> │   └── Menu (Control)
> └── Systems (Node)
>     ├── GameManager (Node)
>     └── SaveManager (Node)
> ```

## System Specifications

### Player System (`src/player/`)

- **Node type:** CharacterBody2D
- **Responsibilities:** Movement, input handling, state (idle, walking, interacting)
- **Signals:** `on_interact`, `on_hurt`, `on_death`
- **Dependencies:** None (standalone)

### Enemy System (`src/enemies/`)

- **Node type:** CharacterBody2D
- **Responsibilities:** Patrol AI, detection, attack
- **State machine:** [idle → patrol → chase → attack → retreat]
- **Dependencies:** Player system (for detection range)

### UI System (`src/ui/`)

- **Node type:** Control / CanvasLayer
- **Responsibilities:** Health bar, interaction prompts, menus
- **Dependencies:** Player system (for health data)

### Systems (`src/systems/`)

- **GameManager:** Global state, game loop, scene transitions
- **SaveManager:** JSON serialization, save slots

## Data Flow

> [Describe how data moves between systems. Example:]
>
> `Player.hurt()` → emits `on_hurt(amount)` → `HUD` connects to signal → updates health bar
>
> `Player.interact()` → emits `on_interact()` → `GameManager` checks context → triggers dialogue

## Asset Requirements

| Asset | Source | Format | Priority |
|-------|--------|--------|----------|
| Player sprite | [Local SDXL / Placeholder] | PNG (spritesheet) | P0 |
| Tileset | [Placeholder] | PNG | P0 |
| SFX (footstep, interact) | [Placeholder] | WAV | P1 |
| Music | [Placeholder] | OGG | P2 |

## Iteration Plan

| Phase | Milestone | Test Criteria | Status |
|-------|-----------|---------------|--------|
| 1 | Player movement works | Character moves, jumps, responds to input | Not started |
| 2 | One interaction | Player can interact with one object | Not started |
| 3 | One enemy | Enemy patrols and reacts to player | Not started |
| 4 | UI | Health bar updates, interaction prompt shows | Not started |
| 5 | Save/Load | Game state persists across sessions | Not started |

## Notes

> [Technical decisions, tradeoffs, things to revisit.]
