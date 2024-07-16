extends Control


signal options_to_main


const WINDOW_MODE := {
	"Windowed": OptionsManager.WindowMode.WINDOWED,
	"Fullscreen": OptionsManager.WindowMode.FULLSCREEN,
	"Borderless": OptionsManager.WindowMode.BORDERLESS_WINDOWED,
}

const ANTI_ALIASING := {
	"Off": RenderingServer.VIEWPORT_MSAA_DISABLED,
	"2x": RenderingServer.VIEWPORT_MSAA_2X,
	"4x": RenderingServer.VIEWPORT_MSAA_4X,
	"8x": RenderingServer.VIEWPORT_MSAA_8X,
}

const VSYNC := {
	"Enabled": true,
	"Disabled": false,
}

@onready var resolution_button: OptionButton = $CenterContainer/VBoxContainer/Resolution/ResolutionButton 
@onready var window_mode_button: OptionButton = $CenterContainer/VBoxContainer/WindowMode/WindowModeButton
@onready var anti_aliasing_button: OptionButton = $CenterContainer/VBoxContainer/AntiAliasing/AntiAliasingButton
@onready var vsync_button: OptionButton = $CenterContainer/VBoxContainer/VSync/VSyncButton


func _ready() -> void:
	# add items to option buttons
	for i in OptionsManager.RESOLUTIONS.size():
		var resolution: Vector2i = OptionsManager.RESOLUTIONS[i]
		var label: String = str(resolution.x) + " x " + str(resolution.y)
		resolution_button.add_item(label, i)
	
	for window_mode_key in WINDOW_MODE.keys():
		window_mode_button.add_item(window_mode_key, WINDOW_MODE.get(window_mode_key))
	
	for anti_aliasing_key in ANTI_ALIASING.keys():
		anti_aliasing_button.add_item(anti_aliasing_key, ANTI_ALIASING.get(anti_aliasing_key))
	
	for vsync_key in VSYNC.keys():
		vsync_button.add_item(vsync_key, int(VSYNC.get(vsync_key)))
	
	# select default items on the option buttons
	window_mode_button.select(window_mode_button.get_item_index(OptionsManager.window_mode))
	anti_aliasing_button.select(anti_aliasing_button.get_item_index(OptionsManager.anti_aliasing))
	vsync_button.select(vsync_button.get_item_index(OptionsManager.vsync_enabled))
	# find will return -1 when no item found
	# get_item_index will also return -1 when no id found, no error is occurred even though -1 is passed as an argument
	# select will deselect all when -1 is passed as an argument
	resolution_button.select(resolution_button.get_item_index(OptionsManager.RESOLUTIONS.find(OptionsManager.resolution)))


func _on_back_button_pressed() -> void:
	AudioPlayer.play_click()
	# hide options screen, display main screen
	options_to_main.emit()


func _on_window_mode_button_item_selected(index: int) -> void:
	AudioPlayer.play_click()
	
	var window_mode := OptionsManager.cast_to_window_mode(window_mode_button.get_item_id(index))
	
	# disable resolution selection if fullscreen
	if window_mode == OptionsManager.WindowMode.FULLSCREEN:
		resolution_button.disabled = true
	else:
		resolution_button.disabled = false
	
	OptionsManager.window_mode = window_mode
	OptionsManager.save_settings()


func _on_anti_aliasing_button_item_selected(index: int) -> void:
	AudioPlayer.play_click()
	
	OptionsManager.anti_aliasing = OptionsManager.cast_to_anti_aliasing(anti_aliasing_button.get_item_id(index))
	OptionsManager.save_settings()


func _on_vsync_button_item_selected(index: int) -> void:
	AudioPlayer.play_click()
	
	OptionsManager.vsync_enabled = bool(vsync_button.get_item_id(index))
	OptionsManager.save_settings()


func _on_resolution_button_item_selected(index: int) -> void:
	AudioPlayer.play_click()
	
	OptionsManager.resolution = OptionsManager.RESOLUTIONS[resolution_button.get_item_id(index)]
	OptionsManager.save_settings()
