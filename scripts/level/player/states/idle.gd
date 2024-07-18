extends State


func _enter() -> void:
	player.playback.travel("idle")


func _fixed_update(delta: float) -> void:
	check_falling()
	
	check_jump()
	
	if player.get_movement_direction():
		transition.emit("walk")
	
	player.decrease_speed(delta)
	
	player.recover_stamina(delta)
