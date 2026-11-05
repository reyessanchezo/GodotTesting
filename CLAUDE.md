# Project Context: Agent-Assisted Game Dev — Godot

## Game Concept

**Working Title:** [TBD]
**Genre:** Narrative-driven exploration (2D)
**Target Audience:** First-time Godot developers
**Scope:** One small area (dungeon floor or forest clearing)

## Core Design Principles

1. **Prove one system at a time** — No combining mechanics until each works in isolation
2. **Decision gates after every milestone** — Ship, cut, or iterate once (never more)
3. **5-minute test** — Every committed line must be explainable by the developer
4. **Iteration packets only** — Structured requests with current state, change, expected behavior, constraints

## Engine & Language

- **Engine:** Godot 4.x
- **Language:** GDScript
- **Rendering:** 2D

## Coding Conventions

- GDScript style: follow [Godot docs style guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- Node naming: `CamelCase` for nodes, `snake_case` for variables/functions
- Signals over direct references between scenes
- One responsibility per script file
- No magic numbers — use `const` or `export` variables

## File Structure

```
src/
├── player/        # Player character, movement, input
├── enemies/       # Enemy types, AI behavior
├── ui/            # HUD, menus, overlays
└── systems/       # Save/load, state machines, utilities
assets/
├── sprites/       # Tilesets, character sprites, UI assets
├── audio/         # SFX, music
└── models/        # (Reserved for future 3D)
```

## Planned Systems (in priority order)

1. Player movement and input
2. One interaction type (e.g., NPC dialogue / environmental puzzle)
3. One enemy type with basic AI
4. Basic UI (health bar, interaction prompt)
5. Save/load system

## What to Avoid

- Multiplayer
- 3D
- Complex physics
- Open world
- Any mechanic not in the MVP GDD

## LLM Interaction Guidelines

- Always read `docs/gdd.md` and `docs/tech-design.md` before generating code
- Provide iteration packets with: current state, requested change, expected behavior, constraints
- Attach screenshots when debugging visual issues
- Update this file and `docs/` as the project evolves
