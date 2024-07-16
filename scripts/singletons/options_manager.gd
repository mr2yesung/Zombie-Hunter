extends Node


enum WindowMode {
	WINDOWED,
	FULLSCREEN,
	BORDERLESS_WINDOWED,
}

const FILE_PATH := "user://options.data"

const RESOLUTIONS := [
	Vector2i(1600, 900), # 1600x900
	Vector2i(1600, 1024), # 1600x1024
	Vector2i(1920, 1080), # 1920x1080
	Vector2i(2560, 1440), # 2560x1440
]

var anti_aliasing := RenderingServer.VIEWPORT_MSAA_DISABLED:
	set(value):
		anti_aliasing = value
		
		RenderingServer.viewport_set_msaa_3d(get_tree().root.get_viewport_rid(), anti_aliasing)

var window_mode := WindowMode.WINDOWED:
	set(value):
		window_mode = value
		
		match window_mode:
			WindowMode.WINDOWED:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
				DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
			WindowMode.FULLSCREEN:
				# setting window to full screen forces the borderless flag to be true
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			WindowMode.BORDERLESS_WINDOWED:
				DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
				DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)

var resolution := Vector2i(1600, 900):
	set(value):
		if value in RESOLUTIONS:
			resolution = value
		else:
			resolution = Vector2i(1600, 900)
		
		get_tree().root.size = resolution
		center_window()

var vsync_enabled := true:
	set(value):
		vsync_enabled = value
		
		if vsync_enabled:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		else:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)


func _ready() -> void:
	load_settings()


func load_settings() -> void:
	var file := FileAccess.open(FILE_PATH, FileAccess.READ)
	if file:
		var value = file.get_var()
		if value and typeof(value) == TYPE_DICTIONARY:
			if value.has("AntiAliasing") and typeof(value["AntiAliasing"]) == TYPE_INT:
				anti_aliasing = cast_to_anti_aliasing(value["AntiAliasing"])
			
			if value.has("WindowMode") and typeof(value["WindowMode"]) == TYPE_INT:
				window_mode = cast_to_window_mode(value["WindowMode"])
			
			if value.has("Resolution") and typeof(value["Resolution"]) == TYPE_VECTOR2I:
				resolution = value["Resolution"]
			
			if value.has("VSync") and typeof(value["VSync"]) == TYPE_BOOL:
				vsync_enabled = value["VSync"]
		file.close()


# should not be called in setter because loading the settings use setter
func save_settings() -> void:
	var settings := {
		"AntiAliasing": anti_aliasing,
		"WindowMode": window_mode,
		"Resolution": resolution,
		"VSync": vsync_enabled,
	}
	
	var file := FileAccess.open(FILE_PATH, FileAccess.WRITE)
	if file:
		file.store_var(settings, true)
		file.close()


func cast_to_anti_aliasing(value: int) -> RenderingServer.ViewportMSAA:
	match value:
		1:
			return RenderingServer.VIEWPORT_MSAA_2X
		2:
			return RenderingServer.VIEWPORT_MSAA_4X
		3:
			return RenderingServer.VIEWPORT_MSAA_8X
		_:
			return RenderingServer.VIEWPORT_MSAA_DISABLED


func cast_to_window_mode(value: int) -> WindowMode:
	var key = WindowMode.find_key(value)
	if key:
		return WindowMode.get(key)
	
	return WindowMode.WINDOWED


func center_window() -> void:
	# top left corner position + size / 2
	var screen_center := DisplayServer.screen_get_position() + DisplayServer.screen_get_size() / 2
	var window_size := get_tree().root.get_size_with_decorations()
	get_tree().root.position = screen_center - window_size / 2
