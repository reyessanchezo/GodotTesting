# Agent-Assisted Game Development — Godot

Experimental repo for testing agentic workflows in game development with Godot 4.x.

## Purpose

This repo documents and scaffolds the iterative, agent-assisted game development process outlined in [agent-assisted-game-dev.md](agent-assisted-game-dev-report/agent-assisted-game-dev.md). The goal is to validate that local and cloud LLMs can reliably assist first-time Godot developers through structured iteration — not one-shot generation.

## Repo Structure

```
.
├── agent-assisted-game-dev-report/   # Research and findings
│   └── agent-assisted-game-dev.md
├── docs/                             # Design documents
│   ├── gdd.md                        # Game Design Document (template)
│   └── tech-design.md                # Technical architecture notes
├── src/                              # Source code (Godot GDScript)
│   ├── player/
│   ├── enemies/
│   ├── ui/
│   └── systems/
├── assets/                           # Game assets
│   ├── sprites/
│   ├── audio/
│   └── models/
├── CLAUDE.md                         # Project context for local LLM
├── .gitignore
└── README.md
```

## Workflow

The project follows the **Iteration Packet** pattern from the research report:

1. **Design** — One-page GDD + tech design in `docs/`
2. **Prototype one system** — Build a single mechanic, test it, verify
3. **Iterate** — Use structured iteration packets (see report §1.4)
4. **Decision gate** — Ship it, cut it, or iterate once more

See `CLAUDE.md` for the full project context the LLM reads on every interaction.

## Tech Stack

- **Engine**: Godot 4.x
- **Language**: GDScript (beginner-friendly; C# available if needed)
- **Local LLM**: Qwen3-4B / Llama 3.1 8B (coding tasks)
- **Cloud LLM**: Claude / GPT-4 (complex systems, asset generation)
- **Asset Pipeline**: Stable Diffusion XL / Flux (sprites, concept art)

## Getting Started

See [GETTING_STARTED.md](GETTING_STARTED.md) for the full setup guide — Godot installation (winget or ZIP), project creation, and verification. The file includes agent-executable PowerShell commands.

After setup, read:
1. `agent-assisted-game-dev-report/agent-assisted-game-dev.md` for the methodology
2. `CLAUDE.md` for the LLM context file
3. `docs/gdd.md` and `docs/tech-design.md` to begin design

## Status

**Pre-production.** No game code yet — repo scaffolded for first prototype.

---

*This is an experimental project. See the research report for methodology and constraints.*
