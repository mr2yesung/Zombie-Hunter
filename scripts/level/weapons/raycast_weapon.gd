extends Weapon


@export var automatic: bool
@export var spark_scene: PackedScene

@onready var cooldown_timer: Timer = $CooldownTimer
@onready var raycast_3d: RayCast3D = $RayCast3D


func _process(delta: float) -> void:
	if Input.is_action_pressed("fire"):
		if cooldown_timer.is_stopped():
			_shoot()
	
	weapon_mesh.position = weapon_mesh.position.lerp(weapon_position, delta * RECOIL_RECOVERY_RATE)


func _shoot() -> void:
	
	cooldown_timer.start(1.0 / fire_rate)
	
	weapon_mesh.position.z += recoil
	
	muzzle_flash.restart()
	
	var collider := raycast_3d.get_collider()
	if raycast_3d.is_colliding():
		# check if collider is enemy
		# if enemy, apply damage and spawn blood particle instead of spark
		var spark := spark_scene.instantiate()
		add_child(spark)
		spark.global_position = raycast_3d.get_collision_point()
