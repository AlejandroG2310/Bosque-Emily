
extends Node

## Reproduce las voces de los personajes en el bus Voice.
## Una voz a la vez.

signal finished

var _player: AudioStreamPlayer

func _ready() -> void:
	_player = AudioStreamPlayer.new()
	_player.bus = "Voice"
	add_child(_player)
	_player.finished.connect(func() -> void: finished.emit())

## Temporalmente utilizamos las voces en portugués para probar.
func locale_folder() -> String:
	return Settings.locale.replace("_", "-")

func play(character: String, file_name: String) -> bool:
	var path := "res://assets/audio/Voice/%s/%s/%s.wav" % [character, locale_folder(), file_name]
	return play_path(path)

func play_path(path: String) -> bool:
	print("Buscando voz: ", path)

	if not ResourceLoader.exists(path):
		push_warning("Voz no encontrada: " + path)
		return false

	_player.stop()
	_player.stream = load(path)

	if _player.stream == null:
		push_warning("No se pudo cargar: " + path)
		return false

	_player.play()
	print("Reproduciendo voz: ", path)

	return true

func stop() -> void:
	_player.stop()

func is_playing() -> bool:
	return _player.playing
