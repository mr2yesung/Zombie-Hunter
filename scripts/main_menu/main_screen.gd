extends Control


func _on_start_button_pressed() -> void:
	AudioPlayer.play_click()
	# hide main screen, show weapon select screen


func _on_options_button_pressed() -> void:
	AudioPlayer.play_click()
	# hide main screen, show options screen


func _on_quit_button_pressed() -> void:
	AudioPlayer.play_click()
	
	# wait for 0.5s before quiting the game
	# this ensures the click sound is played
	var tween: Tween = create_tween()
	tween.tween_interval(0.5)
	tween.tween_callback(end_game)


func end_game() -> void:
	get_tree().quit()
