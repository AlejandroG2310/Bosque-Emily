extends SceneTree

## O AAB da Play tem que alcançar Android 7+ (API 24) e as três ABIs que o app Flutter publicava.
## Sem min_sdk, o Godot sobe o mínimo para 29 com o renderer Mobile e corta Android 7, 8 e 9 (#30).
## Roda como script headless: godot --headless --path . --script res://tools/tests/test_android_reach.gd

const AAB_PRESET_NAME := "Android AAB"
const EXPECTED_MIN_SDK := "24"
const REQUIRED_ARCHITECTURES := ["armeabi-v7a", "arm64-v8a", "x86_64"]

func _init() -> void:
	var failures := check_aab_preset()
	for failure in failures:
		print("FAIL " + failure)
	print("FAILURES: %d" % failures.size())
	quit(mini(failures.size(), 1))

func check_aab_preset() -> Array[String]:
	var presets := ConfigFile.new()
	if presets.load("res://export_presets.cfg") != OK:
		return ["export_presets.cfg nao abriu"]
	var options_section := find_options_section(presets)
	if options_section.is_empty():
		return ["preset '%s' nao encontrado" % AAB_PRESET_NAME]

	var failures: Array[String] = []
	var min_sdk := str(presets.get_value(options_section, "gradle_build/min_sdk", ""))
	if min_sdk != EXPECTED_MIN_SDK:
		failures.append("min_sdk '%s', esperado '%s'" % [min_sdk, EXPECTED_MIN_SDK])
	for architecture in REQUIRED_ARCHITECTURES:
		if not presets.get_value(options_section, "architectures/" + architecture, false):
			failures.append("arquitetura %s desligada" % architecture)
	return failures

func find_options_section(presets: ConfigFile) -> String:
	for section in presets.get_sections():
		if presets.get_value(section, "name", "") == AAB_PRESET_NAME:
			return section + ".options"
	return ""
