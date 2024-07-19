extends HSlider


func _ready() -> void:
	value = OptionsManager.mouse_sensitivity * 1000.0
	
	drag_ended.connect(_on_mouse_sensitivity_slider_drag_ended)


func _on_mouse_sensitivity_slider_drag_ended(_value_changed: bool) -> void:
	# value_changed is false when clicked, but clicking should also trigger setting value
	OptionsManager.mouse_sensitivity = value / 1000.0
	
	OptionsManager.save_settings()
