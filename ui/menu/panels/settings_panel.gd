extends MenuPanel

const QUALITY_KEYS := [
	"settings.quality.low",
	"settings.quality.medium",
	"settings.quality.high"
]

@onready var _music_slider: HSlider = $Panel/Rows/MusicRow/MusicSlider
@onready var _sfx_slider: HSlider = $Panel/Rows/SfxRow/SfxSlider
@onready var _quality_option: OptionButton = $Panel/Rows/QualityRow/QualityOption

func _ready() -> void:
	super()

	_music_slider.value = Settings.music_volume
	_sfx_slider.value = Settings.sfx_volume

	_fill_quality()

	_music_slider.value_changed.connect(
		func(value): Settings.set_value("music_volume", value)
	)

	_sfx_slider.value_changed.connect(
		func(value): Settings.set_value("sfx_volume", value)
	)

	_quality_option.item_selected.connect(
		func(index): Settings.set_value("quality", index)
	)

func _fill_quality() -> void:
	_quality_option.clear()

	for key in QUALITY_KEYS:
		_quality_option.add_item(tr(key))

	_quality_option.selected = Settings.quality