extends State


func _enter() -> void:
	player.playback.travel("run")


func _fixed_update(delta: float) -> void:
	check_falling()
	
	check_jump()
	
	if Input.is_action_just_released("run") or player.stamina <= 0.0:
		transition.emit("walk")
	
	var movement_direction := player.get_movement_direction()
	
	check_idle(movement_direction)
	
	player.move(movement_direction, 2.0)
	
	player.use_stamina(delta)
