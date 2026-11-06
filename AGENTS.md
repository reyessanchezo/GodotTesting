# AGENTS.md — GodotTesting

Single source of truth for agent context in this repo. Cline reads `AGENTS.md` natively as a standard rules format (v3.37.0+); Bionic and the local Qwen/Nemotron models are pointed at it. `CLAUDE.md` and `.clinerules` exist only as pointers to this file — keep them pointers, and add new rules **here**, never in the shims.

## What this repo is

A 2D Godot 4.7 game project developed with local LLM assistance (Cline/Bionic agent harness, models served by LM Studio). The repo root **is** the Godot project — `project.godot` lives here, not in a subfolder. A minimal boot scene is committed (`scenes/main.tscn` + `src/main.gd`); every iteration is measured against it.

## Model stack (LM Studio)

Served by LM Studio on the Ubuntu workstation (24GB 4090, 64GB RAM). All 200k+ context, all vision-language.

| Model | Use for |
|-------|---------|
| `qwen3.8-27b` | Typical interaction — day-to-day default. Dense 27B, strongest coding/agentic scores of the three |
| `qwen3.5-35b-a3b` | Quick changes — small, surgical edits. 35B MoE with 3B active per token, so it runs fast and cheap |
| `nemotron-3.5-super-vl` | Deep thinking — comprehensive / overnight long-horizon sessions |

Because all three are vision-language: when something is broken visually, attach a screenshot of the running game or the Godot editor to the prompt.

## Game Concept

**Working Title:** [TBD]
**Genre:** Narrative-driven exploration (2D)
**Scope:** One small area (dungeon floor or forest clearing)

## Core Design Principles

1. **Prove one system at a time** — no combining mechanics until each works in isolation
2. **Decision gates after every milestone** — ship, cut, or iterate once (never more)
3. **5-minute test** — every committed line must be explainable by the developer
4. **Iteration packets only** — current state, requested change, expected behavior, constraints
5. **Test after every build** — headless boot check, then a visual check in the editor

## Engine & Language

- **Engine:** Godot 4.7 (4.x), 2D
- **Language:** GDScript (both the standard and .NET builds include GDScript; C# requires the .NET build plus the .NET SDK)

## Coding Conventions

- GDScript style: [Godot docs style guide](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- Node naming: `CamelCase`; variables/functions: `snake_case`
- Signals over direct references between scenes
- One responsibility per script file
- No magic numbers — use `const` or `@export`

## File Layout

```
scenes/                  # .tscn scene files (main + one per gameplay element)
src/                     # .gd scripts, organized by system
├── player/              # Player character, movement, input
├── enemies/             # Enemy types, AI behavior
├── ui/                  # HUD, menus, overlays
└── systems/             # Save/load, state machines, utilities
assets/
├── sprites/             # Tilesets, character sprites, UI assets
└── audio/               # SFX, music
docs/
├── gdd.md               # One-page game design document
└── tech-design.md       # System architecture notes
```

## Planned Systems (in priority order)

1. Player movement and input
2. One interaction type (e.g., NPC dialogue / environmental puzzle)
3. One enemy type with basic AI
4. Basic UI (health bar, interaction prompt)
5. Save/load system

## What to Avoid

- Multiplayer, 3D, complex physics, open world
- Any mechanic not in the MVP GDD
- One-shotting multiple systems in a single iteration

## Agent Guidelines

- Before any task: read this file, `docs/gdd.md`, and `docs/tech-design.md`.
- **Verification loop after every code change** (run from the repo root). A step **passes** only if ALL hold: exit code 0, the expected output line present, and no `SCRIPT ERROR` / `Parse Error` / `ERROR` lines in the output. Never gate on exit code alone — Godot 4 headless can exit 0 when a scene's script fails to parse (measured on 4.7.2; the scene just runs as a bare node):
  1. `godot --headless --path . --quit-after 10` → expect exit 0, `[boot] main scene ready`, no error tokens
  2. `godot --headless --path . --check-only --script res://src/<changed>.gd` → parse check for the changed script. Can false-fail a correct script that references an autoload or a `class_name` not yet imported: after adding a new `class_name`, run `godot --headless --path . --import` once first (and once after any fresh clone)
  3. Visual change: press F5 in the editor and confirm the result
- **Overnight / long runs:** use `nemotron-3.5-super-vl`; keep each iteration packet small and self-contained — local models drift over long contexts. Re-anchor by restating this file's constraints at the start of each packet. Never chain more than 3 iterations without a passing verification gate.
- Keep this file and `docs/` in sync when the structure changes.
