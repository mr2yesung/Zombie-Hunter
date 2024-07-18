extends State


func _enter() -> void:
	player.playback.travel("walk")


func _fixed_update(delta: float) -> void:
	check_falling()
	
	check_jump()
	
	if Input.is_action_just_pressed("run"):
		transition.emit("run")
	
	var movement_direction := player.get_movement_direction()
	
	check_idle(movement_direction)
	
	player.move(movement_direction, 1.0)
	
	player.recover_stamina(delta)
