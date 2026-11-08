extends SceneTree

## O jogo é desenhado em paisagem (1920×1080): orientação de celular/tablet tem que ser paisagem.
## Roda como script headless: godot --headless --path . --script res://tools/tests/test_orientation.gd

const LANDSCAPE_ORIENTATIONS := [
	DisplayServer.SCREEN_LANDSCAPE,
	DisplayServer.SCREEN_REVERSE_LANDSCAPE,
	DisplayServer.SCREEN_SENSOR_LANDSCAPE,
]

func _init() -> void:
	var orientation: int = ProjectSettings.get_setting("display/window/handheld/orientation")
	if orientation in LANDSCAPE_ORIENTATIONS:
		print("FAILURES: 0")
		quit(0)
		return
	print("FAIL orientacao %d nao e paisagem" % orientation)
	print("FAILURES: 1")
	quit(1)
