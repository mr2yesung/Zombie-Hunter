extends HSlider


@export var bus_index: int


func _ready() -> void:
	if not OptionsManager.volume.keys().has(bus_index):
		bus_index = 0
	
	value_changed.connect(_on_value_changed)
	drag_ended.connect(_on_drag_ended)
	
	value = db_to_linear(OptionsManager.volume.get(bus_index))


func _on_value_changed(changed_value: float) -> void:
	OptionsManager.set_volume(bus_index, linear_to_db(changed_value))


func _on_drag_ended(_value_changed: bool) -> void:
	# set volume once more to ensure correct value
	OptionsManager.set_volume(bus_index, linear_to_db(value))
	
	# save only when drag is ended, not on every value change
	OptionsManager.save_settings()
