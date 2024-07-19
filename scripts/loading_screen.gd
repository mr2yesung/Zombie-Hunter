extends Control


@export_file("*.tscn") var level_scene_path: String

@onready var progress_label: Label = $CenterContainer/VBoxContainer/ProgressLabel


func _ready() -> void:
	ResourceLoader.load_threaded_request(level_scene_path)


func _process(_delta: float) -> void:
	var progress := []
	ResourceLoader.load_threaded_get_status(level_scene_path, progress)
	progress_label.text = str(int(progress[0] * 100)) + "%"
	
	if progress[0] == 1:
		var level_scene := ResourceLoader.load_threaded_get(level_scene_path)
		get_tree().change_scene_to_packed(level_scene)
