extends Camera3D


const SPEED := 44.0


func _physics_process(delta: float) -> void:
	# blend rotation and position
	global_transform = global_transform.interpolate_with(
		get_parent().global_transform, clampf(delta * SPEED, 0.0, 1.0)
	)
	# set position manually to not blend
	global_position = get_parent().global_position
