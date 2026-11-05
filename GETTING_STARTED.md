# Getting Started

This file contains step-by-step instructions for setting up the full development environment. It is written to be executable by an agent on a Windows 11 machine.

> **Version notes:** Godot 4.7.2 is the current stable release (2026-08-18). If a newer version exists, substitute it. All instructions work for any 4.x stable release.

---

## Step 1 — Install Godot Engine

Choose **one** method below. The winget method is fastest; the ZIP method is the fallback if winget is unavailable.

### Option A: winget (recommended)

Open PowerShell (or Windows Terminal) and run:

```powershell
winget install -e --id GodotEngine.GodotEngine --accept-source-agreements --accept-package-agreements
```

After installation completes, verify:

```powershell
godot --version
```

Expected output: `Godot Engine v4.x.x.stable.mono` or `Godot Engine v4.x.x.stable` (mono suffix indicates .NET/C# support is included).

### Option B: Manual ZIP download

1. Download the standard (GDScript) build:
   ```
   https://downloads.godotengine.org/?version=4.7.2&flavor=stable&slug=win64.exe.zip&platform=windows.64
   ```
   If 4.7.2 has been superseded, go to [godotengine.org/download](https://godotengine.org/download/) and grab the latest stable Windows x86_64 ZIP.

2. Extract the ZIP to a permanent location:
   ```powershell
   Expand-Archive -Path "$env:USERPROFILE\Downloads\Godot_v4.7.2-stable_win64.zip" -Destination "C:\Godot\4.7.2\" -Force
   ```

3. Verify the executable exists:
   ```powershell
   Test-Path "C:\Godot\4.7.2\Godot_v4.7.2-stable_win64.exe"
   ```

   Expected: `True`

---

## Step 2 — Create the Project in Godot

### Option A: From the editor (GUI)

1. Launch Godot:
   ```powershell
   & "C:\Godot\4.7.2\Godot_v4.7.2-stable_win64.exe"
   ```
   (Adjust path if you used winget or a different install location.)

2. In the **Project Manager** that appears, click **+ Create** in the top-right.

3. Fill in:
   - **Project Name:** `AgentGameDev`
   - **Project Path:** `C:\Godot\Projects\AgentGameDev\`
   - **Renderer:** `Forward+ (Default)`
   - **Edit Now:** Checked (default)

4. Click **Create**. Godot generates the project folder and opens the editor.

### Option B: Headless project generation (agent-friendly)

If you need to set up the project without the GUI, generate the minimal `project.godot` file structure:

```powershell
# Create project directory
New-Item -ItemType Directory -Force -Path "C:\Godot\Projects\AgentGameDev"

# Create minimal project.godot (Godot will update this when opened in the editor)
@"
; Engine configuration file.
; It's best edited using the editor UI and not directly,
; but it can also be edited by hand.
; Godot v4.7.2+ compatible.

[application]

config/name="AgentGameDev"

[display]

window/size/viewport_width=1280
window/size/viewport_height=720
window/stretch/mode="canvas_items"

[rendering]

renderer/rendering_method="forward_plus"
"@ | Out-File -FilePath "C:\Godot\Projects\AgentGameDev\project.godot" -Encoding utf8

# Create minimal folder structure
New-Item -ItemType Directory -Force -Path "C:\Godot\Projects\AgentGameDev\scenes"
New-Item -ItemType Directory -Force -Path "C:\Godot\Projects\AgentGameDev\scripts"
New-Item -ItemType Directory -Force -Path "C:\Godot\Projects\AgentGameDev\assets"
```

> **Note:** The stub `project.godot` above is minimal. Open the project in the Godot editor at least once — it will update the file with engine-detected settings.

---

## Step 3 — Link the Project to This Repo

The repo is at `B:\documents\GitHub\GodotTesting`. The Godot project should live inside it.

```powershell
# Move or copy the Godot project into the repo
if (Test-Path "C:\Godot\Projects\AgentGameDev") {
    Move-Item "C:\Godot\Projects\AgentGameDev" "B:\documents\GitHub\GodotTesting\AgentGameDev" -Force
}
```

If the repo folder doesn't exist yet, create it:

```powershell
New-Item -ItemType Directory -Force -Path "B:\documents\GitHub\GodotTesting"
```

The final layout should be:

```
B:\documents\GitHub\GodotTesting\
├── AgentGameDev/              # Godot project (created in Step 2)
│   ├── project.godot
│   ├── scenes/
│   ├── scripts/
│   ├── assets/
│   └── ...
├── docs/
│   ├── gdd.md
│   └── tech-design.md
├── src/
│   ├── player/
│   ├── enemies/
│   ├── ui/
│   └── systems/
├── assets/
│   ├── sprites/
│   ├── audio/
│   └── models/
├── agent-assisted-game-dev-report/
├── CLAUDE.md
├── GETTING_STARTED.md
├── README.md
└── .gitignore
```

---

## Step 4 — Verify Everything Works

1. Open the project in the Godot editor:
   ```powershell
   & "C:\Godot\4.7.2\Godot_v4.7.2-stable_win64.exe" "B:\documents\GitHub\GodotTesting\AgentGameDev"
   ```

2. If you used the stub `project.godot`, Godot will prompt to update it. Click **Update**.

3. The editor should open to the **Main** scene (empty by default). If it opens to the **Project Manager**, click the project name in the list and click **Edit**.

4. Press **F5** (or click the Play button) to run the project. You should see a black window titled "AgentGameDev" that closes immediately (no scenes loaded yet — this is expected).

---

## Step 5 — Install GDScript Language Support (verify)

GDScript is built into the standard Godot build — no extra installation needed. Verify:

1. In the Godot editor, go to **Editor → Editor Settings → Text Editor → Language**
2. Confirm **GDScript** is in the list of available languages
3. When you create a new script (right-click a node → **Attach Script**), GDScript should be the default

If GDScript is missing, you downloaded the wrong build. Re-download the **Standard (64-bit)** build from [godotengine.org/download](https://godotengine.org/download/windows/) — **not** the .NET build unless you need C#.

---

## Recommended Tool Stack

Not all tools are needed at once. The table below is ordered by priority — install each only when you hit a specific bottleneck it solves. Every tool listed is free unless noted.

### Tier 1 — Install Now

| Tool | Purpose | Install |
|------|---------|---------|
| Godot 4.7.2 | Game engine | Step 1 above |
| Git | Version control | `winget install Git.Git` or [git-scm.com](https://git-scm.com/) |
| Pixelorama | Pixel art editor (built with Godot, MIT) | [github.com/Pixelorama/Pixelorama](https://github.com/Pixelorama/Pixelorama) |

These three cover engine, source control, and placeholder art. Nothing else is required to start.

### Tier 2 — Add When Needed

| Tool | Purpose | Install |
|------|---------|---------|
| Blender | 3D modeling, rigging, animation (GPL) | [blender.org](https://www.blender.org/) |
| Krita | Hand-painted 2D art, concept work (GPL) | [krita.org](https://krita.org/) |
| Audacity | Audio cleanup and editing (GPL) | [audacityteam.org](https://www.audacityteam.org/) |
| Kenney.nl asset packs | CC0 placeholder SFX, music, sprites | [kenney.nl/assets](https://kenney.nl/assets) |
| sfxr.me | Browser-based SFX generator (CC0) | [sfxr.me](https://sfxr.me/) |

Blender covers 3D and 2D (Grease Pencil). Krita handles digital painting. Audacity cleans up recorded audio. Kenney and sfxr give you working placeholder audio in minutes.

### Tier 3 — AI Coding Assistants

Choose **one**, not all three.

| Tool | Type | Cost | Best For |
|------|------|------|----------|
| AI Assistant Hub | In-editor plugin | Free (MIT) | Fully local via Ollama; privacy-first |
| Godot AI MCP (dlight) | MCP bridge to Claude Code / Cursor | Free (MIT) | Terminal-based agents that need Godot editor access |
| Ziva | In-editor agent | Free tier / $20/mo | Full agent loop inside the editor |

**Recommendation:** Start with AI Assistant Hub + Ollama (free, local). If you already use Claude Code or Cursor, add Godot AI MCP as the bridge. Only consider Ziva if you want the agent to manipulate scene trees and generate assets inside the editor.

### Tier 4 — Add Later

| Tool | Purpose | When to add |
|------|---------|-------------|
| Aseprite | Professional pixel art ($20) | When Pixelorama's limitations hit |
| Inkscape | Vector UI elements and icons | When you need scalable UI art |
| LMMS | Music composition (DAW) | When you need custom music |
| itch.io account | Game distribution | When you have something to ship |

### What to Skip

Substance Painter, Houdini, Wwise/FMOD, Cascadeur, and Perforce are overkill for a first prototype. Add them only when the project demands their specific capability.

---

## Next Steps (Order of Execution)

These are ordered by dependency — each builds on the previous one.

| # | Task | Depends On | Estimated Time |
|---|------|------------|----------------|
| 1 | **Write the GDD** (`docs/gdd.md`) — fill in the one-page game design document with a concrete concept | None | 30 min |
| 2 | **Write the tech design** (`docs/tech-design.md`) — define scene tree, system specs, data flow | #1 | 30 min |
| 3 | **Set up local LLM** — install Ollama, pull Qwen3-4B or Llama 3.1 8B | None | 15 min |
| 4 | **Create first prototype scene** — empty `Main.tscn` with a `CharacterBody2D` player node | #1, #2 | 15 min |
| 5 | **Write player movement script** — GDScript for movement + jump | #4 | 30 min |
| 6 | **Test player movement** — run the scene, verify controls | #5 | 10 min |
| 7 | **Add one interaction** — NPC dialogue or environmental puzzle | #6 | 1 hr |
| 8 | **Add one enemy type** — patrol AI with detection | #6 | 1-2 hr |
| 9 | **Add UI** — health bar, interaction prompt | #6 | 1 hr |
| 10 | **Decision gate** — playtest, then decide: ship, cut, or iterate | #7, #8, #9 | 30 min |

---

## Troubleshooting

### Godot won't start

- Check that you extracted the ZIP (don't run from inside the archive)
- Run in a PowerShell prompt to see error output:
  ```powershell
  & "C:\Godot\4.7.2\Godot_v4.7.2-stable_win64.exe" 2>&1
  ```
- If you get a Vulkan error, your GPU may only support OpenGL. In the Project Manager, click the **gear icon** next to the project → **Render Mode** → switch to **OpenGL Compatible**

### "Project.godot is not valid" error

- You created a stub `project.godot` but never opened it in the editor. Open the project in the Godot Project Manager and let it update the file.
- Alternatively, create the project fresh via the GUI (Step 2, Option A) and copy the generated `project.godot` into the repo.

### GDScript not available in script dialog

- You downloaded the .NET build but need the standard build. The standard build includes GDScript; the .NET build is for C# only.
- Re-download from [godotengine.org/download](https://godotengine.org/download/windows/) — click **Standard (64-bit)**.

### Winget can't find Godot

- Update winget: `winget upgrade Microsoft.Winget.Source --accept-source-agreements`
- Then retry the install command from Step 1

---

## Sources

- Godot Engine 4.7.2 Windows download: [godotengine.org/download/windows/](https://godotengine.org/download/windows/)
- Godot Windows installation guide: [docs.godotengine.org/en/stable/getting_started/installation/index.html](https://docs.godotengine.org/en/stable/getting_started/installation/index.html)
- SightlessDev Godot setup tutorial: [sightlessdev.com/blog/godot/.../getting-godot-up-and-running](https://www.sightlessdev.com/blog/godot/series/world-1-1-the-fundamentals-gdscript-intro/getting-godot-up-and-running)
- Godot GDScript style guide: [docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_styleguide.html)
