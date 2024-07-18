extends Weapon


@export var automatic: bool
@export var spark_scene: PackedScene
@export var blood_scene: PackedScene

@onready var cooldown_timer: Timer = $CooldownTimer
@onready var raycast_3d: RayCast3D = $RayCast3D


func _process(delta: float) -> void:
	if cooldown_timer.is_stopped():
		if automatic:
			if Input.is_action_pressed("fire"):
				_shoot()
		else:
			if Input.is_action_just_pressed("fire"):
				_shoot()
	
	weapon_mesh.position = weapon_mesh.position.lerp(weapon_position, delta * RECOIL_RECOVERY_RATE)


func _shoot() -> void:
	cooldown_timer.start(1.0 / fire_rate)
	
	weapon_mesh.position.z += recoil
	
	muzzle_flash.restart()
	
	var collider := raycast_3d.get_collider()
	if raycast_3d.is_colliding():
		if collider is Enemy:
			collider.health -= damage
			spawn_particle(blood_scene)
		else:
			spawn_particle(spark_scene)


func spawn_particle(particle_scene: PackedScene) -> void:
	var particle := particle_scene.instantiate()
	add_child(particle)
	particle.global_position = raycast_3d.get_collision_point()
