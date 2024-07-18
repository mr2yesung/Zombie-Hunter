extends Weapon


@export var damage: int
@export var automatic: bool
@export var spark_scene: PackedScene
@export var blood_scene: PackedScene

@onready var raycast_3d: RayCast3D = $RayCast3D


func _process(delta: float) -> void:
	if automatic:
		if Input.is_action_pressed("fire"):
			_shoot(shoot_raycast)
	else:
		if Input.is_action_just_pressed("fire"):
			_shoot(shoot_raycast)
	
	recover_recoil(delta)


func shoot_raycast() -> void:
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
