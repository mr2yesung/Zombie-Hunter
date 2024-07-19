extends Control


func _ready() -> void:
	visible = false


func pause_game() -> void:
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true


func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	AudioPlayer.play_click()
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	visible = false


func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	AudioPlayer.play_click()
	
	GameSceneManager.move_to_menu()
