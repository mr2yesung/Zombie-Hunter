extends Control


func _ready() -> void:
	visible = false


func game_over() -> void:
	visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true


func _on_menu_button_pressed() -> void:
	get_tree().paused = false
	GameSceneManager.move_to_menu()
