extends Control


signal select_to_main
signal start_game

@onready var weapon_displayer: Node3D = $CenterContainer/HBoxContainer/SubViewportContainer/SubViewport/WeaponDisplayer
@onready var weapon_selection_buttons := $CenterContainer/HBoxContainer/VBoxContainer.get_children()


func _ready() -> void:
	for button in weapon_selection_buttons:
		if button is WeaponSelectionButton:
			button.pressed.connect(_on_weapon_selection_pressed.bind(button))
			
			# press the default button and render the mesh
			# this allows to maintain the player weapon easier
			# and prevent start button from unnecessary disable
			if button.weapon_type == WeaponManager.player_main_weapon:
				# manually setting button_pressed to true does not call the callback connected to pressed signal
				button.button_pressed = true
				button.render_weapon(weapon_displayer)


func _process(delta: float) -> void:
	weapon_displayer.rotate_y(delta)


func _on_weapon_selection_pressed(pressed_button: WeaponSelectionButton):
	AudioPlayer.play_click()
	
	# delete previous meshes
	for weapon_mesh in weapon_displayer.get_children():
		weapon_mesh.queue_free()
	
	pressed_button.render_weapon(weapon_displayer)
	
	WeaponManager.player_main_weapon = pressed_button.weapon_type


func _on_back_button_pressed() -> void:
	AudioPlayer.play_click()
	
	select_to_main.emit()


func _on_start_button_pressed() -> void:
	AudioPlayer.play_click()
	
	start_game.emit()
