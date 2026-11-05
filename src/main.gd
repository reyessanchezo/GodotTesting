extends Node2D
## Root scene for the GodotTesting project.
##
## Intentionally minimal: this is the "game already runs" baseline that every
## iteration is measured against. Gameplay goes in src/player/, src/enemies/,
## etc. — don't grow this file.

func _ready() -> void:
	# Traceable boot log: shows in the editor Output panel and in
	# `godot --headless --quit-after N` runs, so agent iterations can verify
	# the game boots without opening the editor.
	print("[boot] main scene ready")
