# GodotTesting — Agent-Assisted Game Development

A 2D Godot 4.7 game project used to test agent-assisted game development with local LLMs. The repo root **is** the Godot project — open `project.godot` directly in the editor; there is no nested project folder.

The method follows the research in [agent-assisted-game-dev.md](agent-assisted-game-dev-report/agent-assisted-game-dev.md): design first, build one system at a time, test after every build, then apply decision gates (ship / cut / iterate once — never more).

## Layout

```
.
├── project.godot                     # Godot 4.7 project config (repo root IS the project)
├── scenes/
│   └── main.tscn                     # Minimal boot scene — the "game already runs" baseline
├── src/
│   ├── main.gd                       # Boot log; gameplay systems go below
│   ├── player/
│   ├── enemies/
│   ├── ui/
│   └── systems/
├── assets/
│   ├── sprites/
│   └── audio/
├── docs/
│   ├── gdd.md                        # One-page game design document (template)
│   └── tech-design.md                # Technical architecture notes
├── agent-assisted-game-dev-report/   # Research and findings
│   └── agent-assisted-game-dev.md
├── AGENTS.md                         # Single source of truth for agent context (Cline/Bionic/local models)
├── CLAUDE.md                         # Pointer → AGENTS.md (for tools that look for CLAUDE.md)
├── .clinerules                       # Cline entry point — points at AGENTS.md
├── GETTING_STARTED.md                # Install, open, verify, tool stack
├── README.md
└── .gitignore                        # Official Godot template (scenes/resources/assets ARE versioned)
```

## Workflow

The **Iteration Packet** pattern from the report:

1. **Design** — one-page GDD + tech design in `docs/`
2. **Prototype one system** — build a single mechanic in isolation
3. **Verify** — headless boot check (`godot --headless --path . --quit-after 10`) plus a visual F5 check
4. **Iterate** — structured iteration packet (current state, change, expected behavior, constraints)
5. **Decision gate** — ship it, cut it, or iterate once more

The agent's context entry point is `AGENTS.md` (single source of truth, read natively by Cline); `CLAUDE.md` and `.clinerules` are pointers to it.

## Stack

- **Engine:** Godot 4.7, GDScript, 2D
- **Agent:** Cline (VS Code) or Bionic (LM Studio), running locally
- **Models (LM Studio, Ubuntu workstation):** `qwen3.8-27b` for typical interaction; `qwen3.5-35b-a3b` for quick changes; `nemotron-3.5-super-vl` for deep thinking / overnight sessions — all 200k+ context, all VL
- **Art (placeholder):** Pixelorama, Kenney CC0 packs, sfxr.me
- **Version control:** Git — one small commit per verified iteration

## Getting Started

See [GETTING_STARTED.md](GETTING_STARTED.md) — install Godot, verify the LM Studio model stack, open the repo as the project, and run the baseline verification. After that:

1. `agent-assisted-game-dev-report/agent-assisted-game-dev.md` — the methodology
2. `AGENTS.md` — what the agent reads before every task
3. `docs/gdd.md` and `docs/tech-design.md` — fill in the design, then start iteration 1 (player movement)

## Status

**Pre-production.** A booting main scene is committed. Next: write the GDD, then iteration 1 (player movement and input).

---

*Experimental project. See the research report for methodology and constraints.*
