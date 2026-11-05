# Getting Started

Setup for this machine: Windows 11, local agent (Cline or Bionic), local models via Ollama. Every command is written to be executable by an agent; each step ends with a verification check.

> **Versions:** Godot 4.7.2 is the current stable (released 2026-08-18); the winget package ID and download link below were verified against it. If a newer 4.x stable exists, the same steps apply with the new version number.

---

## Step 1 — Install Godot

### Option A: winget (recommended)

```powershell
winget install -e --id GodotEngine.GodotEngine --accept-source-agreements --accept-package-agreements
```

Package `GodotEngine.GodotEngine` is published by Godot Engine (v4.7.2, verified at [winstall.app/apps/GodotEngine.GodotEngine](https://winstall.app/apps/GodotEngine.GodotEngine)). It installs the standard editor and registers `godot` / `godot_console` aliases.

**Open a new terminal** so the aliases are on PATH, then verify:

```powershell
godot --version
# Expected: Godot Engine v4.7.2.stable
```

### Option B: manual ZIP

1. Download the standard (GDScript) build:
   ```
   https://downloads.godotengine.org/?version=4.7.2&flavor=stable&slug=win64.exe.zip&platform=windows.64
   ```
   (or the latest stable from [godotengine.org/download/windows/](https://godotengine.org/download/windows/))

2. Extract:
   ```powershell
   Expand-Archive -Path "$env:USERPROFILE\Downloads\Godot_v4.7.2-stable_win64.exe.zip" -Destination "C:\Godot\4.7.2\" -Force
   ```

3. Verify:
   ```powershell
   Test-Path "C:\Godot\4.7.2\Godot_v4.7.2-stable_win64.exe"   # Expected: True
   ```

Use `& "C:\Godot\4.7.2\Godot_v4.7.2-stable_win64.exe"` in later steps if you went this route.

---

## Step 2 — Install Ollama and the working models

```powershell
winget install Ollama.Ollama
```

If winget can't find it, `winget search ollama` or download from [ollama.com/download](https://ollama.com/download). Open a **new terminal**, then pull the models:

```powershell
ollama pull qwen3:30b                # day-to-day — Qwen3-30B-A3B (MoE, ~19GB, 256K context)
ollama pull nemotron-3.5-super:120b  # overnight — Nemotron 3.5 Super (120B MoE, 80–90GB, 1M context, vision)
ollama list                          # both models should appear
```

**Model policy (also in CLAUDE.md):** Qwen 30B for day-to-day coding and iteration; Nemotron 3.5 Super 120B for comprehensive / long autonomous sessions. `qwen3:32b` (dense, ~20GB, 40K context) is the alternative day-to-day tag if you prefer dense over MoE. Note the overnight model downloads ~80–90GB and needs a machine with the RAM to serve it — if this box can't host it, run the loop on qwen3:30b and pull it where it will run. Tags verified against the Ollama library on 2026-11-05 ([qwen3](https://ollama.com/library/qwen3), [nemotron-3.5-super](https://ollama.com/library/nemotron-3.5-super)).

---

## Step 3 — Open this repo in the Godot editor

The repo root **is** the Godot project — `project.godot` is already committed here. There is nothing to create.

1. Launch the Project Manager:
   ```powershell
   godot
   ```
   (or `& "C:\Godot\4.7.2\Godot_v4.7.2-stable_win64.exe"` for the ZIP install)

2. If the project doesn't appear in the list, click **Import**, browse to:
   ```
   B:\Documents\GitHub\GodotTesting\project.godot
   ```
   and click **Import**.

3. Click **Edit** next to the project. The first open triggers asset import — wait for it to finish. Godot may add default settings keys to `project.godot`; that's expected, commit the result.

---

## Step 4 — Verify the baseline

A minimal main scene is committed (`scenes/main.tscn` + `src/main.gd`: one node, one label, one print). This is the "start from a game that already runs and that you understand line by line" baseline every iteration is measured against.

1. **Visual check** — press **F5**. Expected: a 1280×720 window titled "GodotTesting" showing the label **Boot OK — main scene running**, and in the Output panel:
   ```
   [boot] main scene ready
   ```

2. **Headless boot check** (the command the agent runs to verify every iteration without the editor):
   ```powershell
   cd B:\Documents\GitHub\GodotTesting
   godot --headless --path . --quit-after 10
   ```
   **Pass = all three:** exit code 0, `[boot] main scene ready` present, and no `SCRIPT ERROR` / `Parse Error` / `ERROR` lines in the output. Do not gate on the exit code alone — on Godot 4, a scene whose script fails to parse still runs as a bare node and the run can exit 0 (measured on 4.7.2; see [Sources](#sources)).

3. **Single-script parse check** (fast, no game boot):
   ```powershell
   godot --headless --path . --check-only --script res://src/main.gd
   ```
   Expected: clean exit, no parse errors. Caveat: this check can *false-fail* a correct script that references an autoload or a `class_name` that hasn't been imported yet, and on a fresh clone it misjudges before the first import — after adding a new `class_name`, or on a fresh clone, run `godot --headless --path . --import` once first.

If all three pass, the environment is ready and iteration 1 (player movement) can start.

---

## Recommended Tool Stack

Ordered by priority — install each only when it removes a specific bottleneck.

### Tier 1 — Installed as part of setup

| Tool | Purpose | Status |
|------|---------|--------|
| Godot 4.7.2 | Engine (Step 1) | Standard build includes GDScript; the .NET build adds C# (requires .NET SDK) |
| Ollama | Local model runtime (Step 2) | Qwen 27–30B + Nemotron 120B pulled |
| Cline or Bionic | Agent harness driving the iteration loop | Cline in VS Code (reads `.clinerules`), or Bionic in LM Studio |
| Git | Version control | `winget install Git.Git` or [git-scm.com](https://git-scm.com/) |

### Tier 2 — Add when needed

| Tool | Purpose | Link |
|------|---------|------|
| Pixelorama | Pixel art editor, built with Godot (MIT) | [github.com/Pixelorama/Pixelorama](https://github.com/Pixelorama/Pixelorama) |
| Kenney.nl asset packs | CC0 placeholder SFX, music, sprites | [kenney.nl/assets](https://kenney.nl/assets) |
| sfxr.me | Browser SFX generator (CC0) | [sfxr.me](https://sfxr.me/) |
| Blender | 3D / Grease Pencil 2D (GPL) | [blender.org](https://www.blender.org/) |
| Krita | Hand-painted 2D art (GPL) | [krita.org](https://krita.org/) |
| Audacity | Audio cleanup (GPL) | [audacityteam.org](https://www.audacityteam.org/) |

### Tier 3 — Optional / later

| Tool | Purpose | When to add |
|------|---------|-------------|
| Godot Editor MCP ([hybridindie/godot-mcp](https://github.com/hybridindie/godot-mcp), MIT) | Editor bridge: agent drives the live editor — scene tree, nodes, signals, with undo | If direct `.tscn` edits start producing spatial/scene-tree errors |
| Aseprite | Professional pixel art ($20) | When Pixelorama's limits are hit |
| Inkscape | Vector UI icons | When you need scalable UI art |
| LMMS | Music composition (DAW) | When placeholder music isn't enough |
| itch.io account | Distribution | When there's something to ship |

### What to skip

Substance Painter, Houdini, Wwise/FMOD, Cascadeur, Perforce — overkill for a first 2D prototype.

---

## Next Steps (Order of Execution)

Ordered by dependency — each builds on the previous.

| # | Task | Depends On | Est. Time |
|---|------|------------|-----------|
| 1 | **Write the GDD** — fill in `docs/gdd.md` with a concrete concept (title, core mechanic, scope) | None | 30 min |
| 2 | **Write the tech design** — scene tree, system specs, data flow in `docs/tech-design.md` | #1 | 30 min |
| 3 | **Iteration 1: player movement** — `src/player/player.gd`, movement + input map, new `scenes/player.tscn` | #1, #2 | 30–60 min |
| 4 | **Verify** — headless boot check + F5, commit | #3 | 10 min |
| 5 | **Iteration 2: one interaction** — NPC dialogue or environmental puzzle | #4 | 1 hr |
| 6 | **Iteration 3: one enemy type** — patrol AI with detection | #4 | 1–2 hr |
| 7 | **Iteration 4: UI** — health bar, interaction prompt | #4 | 1 hr |
| 8 | **Decision gate** — playtest, then ship / cut / iterate once | #5, #6, #7 | 30 min |

---

## Troubleshooting

### `godot` not recognized after winget install

Open a **new** terminal — winget PATH changes don't apply to already-open shells. If still missing, check `winget list --id GodotEngine.GodotEngine`.

### Project doesn't appear in the Project Manager

Use **Import** (not Create) and point it at `B:\Documents\GitHub\GodotTesting\project.godot`. The project is already committed; creating a new one would produce a second, conflicting project.

### F5 shows "No main scene set" or the project fails to open

`project.godot` should contain `run/main_scene="res://scenes/main.tscn"` under `[application]`. If it's missing, set **Project Settings → Application → Run → Main Scene** to `scenes/main.tscn`.

### Headless check prints script errors

Read the first error line — it names the file and line. Fix, re-run `godot --headless --path . --quit-after 10` until exit 0. This is the agent's normal loop, not an environment problem.

### Vulkan / rendering errors on launch

Your GPU may need the Compatibility renderer: **Project Settings → Rendering → Renderer** → switch to `gl_compatibility`, then re-verify with F5.

### C# not available (only relevant if you switch to the .NET build)

The .NET build requires the [.NET SDK](https://dotnet.microsoft.com/download). Note: GDScript works in **both** builds — the .NET build adds C#, it does not remove GDScript.

---

## Sources

- Godot 4.7.2 Windows download: [godotengine.org/download/windows/](https://godotengine.org/download/windows/)
- Godot installation docs: [docs.godotengine.org](https://docs.godotengine.org/en/stable/getting_started/installation/index.html)
- winget package `GodotEngine.GodotEngine`: [winstall.app/apps/GodotEngine.GodotEngine](https://winstall.app/apps/GodotEngine.GodotEngine)
- Official Godot .gitignore template: [github/gitignore — Godot.gitignore](https://github.com/github/gitignore/blob/main/Godot.gitignore)
- GDScript style guide: [docs.godotengine.org](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
- Project organization best practices: [docs.godotengine.org](https://docs.godotengine.org/en/stable/tutorials/best_practices/project_organization.html)
- Godot 4.7.2 release (2026-08-18): [github.com/godotengine/godot — 4.7.2-stable](https://github.com/godotengine/godot/releases/tag/4.7.2-stable)
- Ollama model tags: [ollama.com/library/qwen3](https://ollama.com/library/qwen3), [ollama.com/library/nemotron-3.5-super](https://ollama.com/library/nemotron-3.5-super)
- Headless exit-code traps (measured on 4.7.2): [Godot forum — "Things that exit 0 in Godot 4 headless even though they failed"](https://forum.godotengine.org/t/things-that-exit-0-in-godot-4-headless-even-though-they-failed-measured-reproducible/145990)
