# Agent-Assisted Game Development: Report for First-Time Godot Developers

## Executive Summary

Developers are creating games with local and cloud LLMs primarily through an iterative, incrementally-verified workflow—not by one-shotting a complete game. The proven pattern is: design first, build one system at a time, test after each build, then refine. The most successful projects treat the LLM as a production assistant, not a creative director. Your friend's D&D campaign design experience is a genuine advantage for narrative structure, encounter design, and pacing—skills that translate directly to game design. The biggest risks are feature creep, comprehension debt (code you can't explain), and spatial reasoning gaps that require human correction.

---

## 1. How Developers Have Created Games with Agents

### 1.1 The Iterative Increment Pattern

The dominant successful pattern across all reported cases is **build one piece, test it, then move on**. This appears in every workflow documented:

- **Ryan Fitzpatrick's workflow** ([ryanfitzpatrick.io](https://ryanfitzpatrick.io/blog/llm-assisted-game-development-workflow)): Builds and alternates between two states—build (new feature) and refine (improve existing). Tests after every build phase before moving into refinement. Tests again after refinement for regression.
- **GameDev.net CIGDI framework** ([gamedev.net](https://gamedev.net/blogs/entry/2297316)): Research → Ideation → Prototyping → Playtesting → Review → Action → Integration, with decision gates at each stage. The team shipped "The Worm's Memoirs" in 3 months part-time using this.
- **Aalto OpenCS iteration guide** ([fitech101.aalto.fi](https://fitech101.aalto.fi/en/courses/introduction-to-programming-summer-2026/part-9/11-iterating-with-ai-on-a-game)): "Start from a game that already runs and that you understand line by line. Then ask for one change." Uses an "iteration packet" format for each request.

### 1.2 Project Configuration Before Coding

Multiple sources agree: configure the project for AI *before* writing game code. This takes ~30 minutes and pays dividends:

- Create a project context file (`CLAUDE.md`, `.cursorrules`, or `README.md`) at the repo root describing the game concept, engine, language, coding conventions, file structure, and planned systems ([abratabia.com](https://www.abratabia.com/ai-game-development/ai-game-workflow.php)).
- Organize code into named directories (`src/player/`, `src/enemies/`, `src/ui/`, `src/physics/`) so the AI knows where to place code.
- Set up Git from day one with frequent small commits so AI-generated mistakes can be reverted in seconds.

### 1.3 What Agents Do Well (and Where They Fail)

**Agents are strong at:**
- Code scaffolding, boilerplate, and technical systems (shaders, save systems, multiplayer logic, build scripts)
- Explaining technical concepts and debugging specific errors
- Asset generation (concept art, sprites, textures) and audio generation
- Refactoring, localization, and performance optimization
- Level concepts and layout ideas

**Agents are weak at:**
- Spatial reasoning: camera math, object alignment, forward direction, positioning relative to scene context ([ryanfitzpatrick.io](https://ryanfitzpatrick.io/blog/llm-assisted-game-development-workflow))
- Game feel: animation timing, camera reactions, haptics, "juice"
- Making taste-driven design decisions
- Multiplayer netcode (state sync, prediction, reconciliation) without careful review
- Long-term memory leak detection

### 1.4 The Iteration Packet Format

A proven technique for getting useful results from an agent is the **iteration packet**—a structured request containing:

1. **Current state**: What the game does now
2. **Change being requested**: One specific modification
3. **Expected behavior**: What should happen after the change
4. **Constraints**: What must not break

The Aalto guide emphasizes: *"A weak request: 'Make this game better.' A useful request: [iteration packet with specific facts]."* The more concrete the behavior description, the better the implementation.

### 1.5 Real Projects Built This Way

- **Godogen** ([github.com/htdt/godogen](https://github.com/htdt/godogen)): Autonomous game development tool for Godot (C# or GDScript), Bevy, Babylon.js, and three.js. It generates code, assets, runs the engine, and verifies results. Picks Godot/C# for "the fewest runtime surprises in long unattended runs."
- **Local Agents** ([github.com/adammikulis/local-agents](https://github.com/adammikulis/local-agents)): Godot 4.5 plugin that runs LLMs *inside* games using llama.cpp and .gguf models. NPCs get dynamic dialogue and actions at runtime.
- **Salvo's living city** ([dev.to](https://dev.to/salvo10f/i-gave-an-ai-agent-one-prompt-and-it-built-a-living-city-in-godot-4-3mlm)): Built a city with roads, buildings, park, moving cars, and day/night cycle using Claude Code + Cursor. Took 41 tiles in one call for roads. The agent ran the game, took a screenshot, and verified visuals.
- **OpenCode lunar lander** ([hotelexistence.ca](https://www.hotelexistence.ca/coding-agent-2025/index.md)): Built by someone who'd never used Godot. Used plan mode to clarify requirements, then build mode. First build had a casting error; pasted the error to OpenCode and it fixed it.

---

## 2. D&D Campaign Design Experience: Translation to Game Development

Your friend's D&D experience is genuinely valuable, not just "narrative skills." Here's the direct mapping:

### 2.1 Skills That Translate Directly

| D&D Skill | Video Game Equivalent |
|-----------|----------------------|
| Encounter design (balancing enemy groups, difficulty) | Enemy AI balancing, difficulty curves, combat encounters |
| Dungeon/level layout and pacing | Level design, room placement, player pathing |
| Narrative beats and story structure | Quest design, branching narratives, environmental storytelling |
| Resource management (spell slots, hp, inventory) | Player economy, progression systems, power curves |
| "Reading the table" and adapting | Playtesting, player feedback analysis, iterative design |
| Tension and release pacing | Cutscene timing, gameplay rhythm, challenge/reward cycles |
| Creating meaningful choices | Branching dialogue, multiple solution paths, player agency |

### 2.2 What D&D DMs Already Understand

- **Cognitive load management**: "Don't overwhelm players with too much information too quickly" ([gormandev.com](https://www.gormandev.com/post/dnd-teaches-game-design-vol1))—this is literally level design in video games (focal points, leading lines, spatial composition).
- **Resource pacing**: "Drip feed resources at the right times so rewards feel earned" ([gormandev.com](https://www.gormandev.com/post/dnd-teaches-game-design-vol1)). The God of War example: new item every 90–120 minutes, followed by a level that forces its use.
- **Not being an "evil designer"**: "Keep the players' enjoyment in mind" ([gamedeveloper.com](https://www.gamedeveloper.com/design/a-video-game-dev-learning-from-d-d)). Don't ambush first-level players with an army of goblins.
- **Balance tension and release**: Cutscenes as downtime. This is exactly how game pacing works.

### 2.3 What D&D DMs Need to Learn

- **Fixed vs. emergent systems**: In D&D, the DM adapts to player choices. In video games, the designer must predict and handle all possible player paths. This is the core challenge of game programming.
- **Deterministic implementation**: A D&D trap that "deals 2d6 damage if triggered" becomes a collision check, damage formula, and animation sequence in code. The DM describes intent; the programmer specifies behavior.
- **Scope discipline**: D&D campaigns can run for years. Video game prototypes need shipping deadlines. This is the hardest lesson for TTRPG designers.

---

## 3. Recommended Workflow for Your Friend

### Phase 0: Setup (Day 1)

1. **Install Godot 4.x** (GDScript for beginners, C# for experienced programmers)
2. **Create project folder** with structure:
   ```
   game-project/
   ├── project.godot
   ├── CLAUDE.md          # Project context for local LLM
   ├── docs/
   │   ├── gdd.md         # One-page game design document
   │   └── tech-design.md # System architecture notes
   ├── src/
   │   ├── player/
   │   ├── enemies/
   │   ├── ui/
   │   └── systems/
   ├── assets/
   │   ├── sprites/
   │   ├── audio/
   │   └── models/
   └── .gitignore
   ```
3. **Write `CLAUDE.md`** with: game concept, engine/language, coding conventions, file structure, planned systems. This file is read by the local LLM on every interaction and keeps it aligned.
4. **Write the one-page GDD** covering: core mechanic, win/lose conditions, player progression, scope limits.

### Phase 1: Design with LLM Assistance (Days 2–3)

1. **Brainstorm with the local LLM**: Feed it the core concept and ask for mechanic variations, edge cases, and scope suggestions.
2. **Use the LLM to identify technical risks**: "What systems in this design are hardest to implement in Godot?"
3. **Break the GDD into phases**, each with a testable milestone. This is critical—without phases, the LLM will dump everything into one file.

### Phase 2: First Prototype—Prove One System (Days 4–10)

**Rule: Prove one system at a time before combining them.**

1. Start with the **simplest possible implementation** of the core mechanic.
2. Use the **iteration packet format** for each request to the local LLM.
3. **Test after every build**. Play the game, not just check if it compiles.
4. **Understand every line of code before committing it** (the "5-minute test": can you explain it to a friend? modify it? debug it?).

**Good first systems to prototype:**
- Player movement and input
- One enemy type with basic AI
- One interaction (pick up, attack, talk)
- Basic UI (health bar, inventory)

### Phase 3: Playtest and Iterate (Days 11–14)

1. Get 3–5 people to play the prototype.
2. Use the local LLM to analyze feedback patterns.
3. Apply decision gates: **Ship it**, **Cut it**, or **Iterate once** (then decide again).
4. Never iterate more than once without shipping or cutting.

### Phase 4: Expand (Days 15+)

Repeat Phase 2–3 for each new system. Build features in isolation, then integrate.

---

## 4. Local LLM Specific Considerations

### 4.1 What Works Well Locally

- **Code generation and explanation**: Local models (Qwen, Llama, Mistral variants) handle GDScript well for scaffolding and debugging.
- **Asset generation**: Use local image generators (Stable Diffusion) for concept art and sprite generation.
- **Research and design**: Local LLM is excellent for brainstorming, GDD drafting, and technical risk analysis.

### 4.2 What May Need Cloud Models

- **Complex code generation**: For intricate systems (networking, advanced shaders), a larger cloud model (Claude, GPT-4) may produce better results.
- **Image generation for assets**: If the local setup doesn't include a capable image generator, cloud services produce better results.
- **3D asset generation**: Tools like Meshy, Tripo3D, or cloud-based generators.

### 4.3 Prompting Tips for Local LLMs

- **Be specific about behavior**: "When the player presses space and is on the ground, add upward velocity of 8.0" not "make the player jump."
- **Provide working references**: "This works in project X. Do it this way in project Y."
- **Give the LLM eyes**: Take screenshots of the game state when something is broken and attach them to the prompt.
- **Keep context files current**: Update `CLAUDE.md` and `docs/` as the project evolves. The LLM's understanding is only as good as its context.

---

## 5. Common Pitfalls and How to Avoid Them

### Pitfall 1: Feature Creep
**Problem**: AI generates infinite ideas. The prototype becomes unshippable.
**Solution**: Decision gates. "If it's not in the MVP doc, it doesn't exist." Kill ruthlessly.

### Pitfall 2: Comprehension Debt
**Problem**: Code works but your friend can't explain it. It becomes unmaintainable.
**Solution**: The 5-minute test. Ask the LLM to explain every pattern it uses. Implement simpler versions yourself first, then use the AI version if you understand it.

### Pitfall 3: One-Shotting
**Problem**: Asking the LLM to "build a game" produces a pile of untested code.
**Solution**: Build one piece, test it, then move on. The strongest workflow is never one-shotting.

### Pitfall 4: Spatial Reasoning Gaps
**Problem**: Objects placed in wrong positions, cameras facing wrong direction, alignment issues.
**Solution**: Human inspection is required. Use the local LLM for code and logic, not for visual placement. If using tools like GodotIQ (MCP server for spatial awareness), leverage them for scene inspection.

### Pitfall 5: LLM Slop
**Problem**: More output ≠ better game. Generic feel, bad cohesion, overcomplicated code.
**Solution**: Human taste is the filter. Curate aggressively. The LLM multiplies output; you control direction.

---

## 6. Suggested First Project for Your Friend

Given the D&D background, a **narrative-driven exploration game** in Godot 2D is the ideal first project:

- **Scope**: One small area (a dungeon floor or forest clearing)
- **Core mechanic**: Exploration + one interaction type (e.g., talking to NPCs, solving environmental puzzles)
- **Why it works**: Leverages narrative design skills, has clear testable milestones, GDScript is beginner-friendly, and Godot's 2D tooling is excellent.
- **What to avoid**: Multiplayer, 3D, complex physics, or open world in the first project.

---

## 7. Your Role as the LLM Infrastructure Person

Your friend's success depends heavily on your setup. Focus on:

1. **Local model selection**: Qwen3-4B or Llama 3.1 8B are solid for coding tasks locally. For asset generation, Stable Diffusion XL or Flux.
2. **MCP server setup**: If using Claude Code or Cursor, set up any Godot-specific MCP servers (like GodotIQ for spatial awareness).
3. **Asset pipeline**: Local image generation for sprites/concept art. Audio tools for sound design.
4. **Version control discipline**: Enforce Git with small commits. This is non-negotiable for AI-assisted development.
5. **Context management**: Help maintain `CLAUDE.md` and documentation as the project evolves. The LLM's effectiveness drops without fresh context.

---

## Sources

- Fitzpatrick, R. "LLM Assisted Game Development Workflow." [ryanfitzpatrick.io/blog/llm-assisted-game-development-workflow](https://ryanfitzpatrick.io/blog/llm-assisted-game-development-workflow)
- Abratabia. "A Practical AI-Assisted Game Development Workflow." [abratabia.com/ai-game-development/ai-game-workflow.php](https://www.abratabia.com/ai-game-development/ai-game-workflow.php)
- Zeena. "How to Structure AI Use in Your Indie Game Development." [gamedev.net/blogs/entry/2297316](https://gamedev.net/blogs/entry/2297316)
- Salvo. "I Gave an AI Agent One Prompt and It Built a Living City in Godot 4." [dev.to/salvo10f](https://dev.to/salvo10f/i-gave-an-ai-agent-one-prompt-and-it-built-a-living-city-in-godot-4-3mlm)
- Aalto OpenCS. "Iterating With AI on a Real Project." [fitech101.aalto.fi](https://fitech101.aalto.fi/en/courses/introduction-to-programming-summer-2026/part-9/11-iterating-with-ai-on-a-game)
- Hotelexistence. "Creating a Game with the OpenCode Coding Agent." [hotelexistence.ca/coding-agent-2025](https://www.hotelexistence.ca/coding-agent-2025/index.md)
- Gorman, S. "D&D Teaches Game Design? Vol #1." [gormandev.com/post/dnd-teaches-game-design-vol1](https://www.gormandev.com/post/dnd-teaches-game-design-vol1)
- Larsen, S. "A Video Game Dev Learning from D&D." [gamedeveloper.com/design/a-video-game-dev-learning-from-d-d](https://www.gamedeveloper.com/design/a-video-game-dev-learning-from-d-d)
- Martin, G.D. "How the Developer of In Other Waters Transformed Their Game into a TTRPG." [gamedeveloper.com/design/how-the-developer-of-in-other-waters-transformed-their-game-into-a-tabletop-rpg](https://www.gamedeveloper.com/design/how-the-developer-of-in-other-waters-transformed-their-game-into-a-tabletop-rpg)
- Local Agents plugin: [github.com/adammikulis/local-agents](https://github.com/adammikulis/local-agents)
- Godogen: [github.com/htdt/godogen](https://github.com/htdt/godogen)
- ChatGE paper: [aclanthology.org/2025.acl-long.218.pdf](https://aclanthology.org/2025.acl-long.218.pdf)
