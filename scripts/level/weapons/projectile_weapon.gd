extends Weapon


@export var ammo_scene: PackedScene
@export var particle_damage: int
@export var spread := false
@export var particle_per_ammo := 1
@export var ammo_initial_position: Marker3D


func _process(delta: float) -> void:
	if cooldown_timer.is_stopped():
		if Input.is_action_just_pressed("fire"):
			_shoot()
	
	recover_recoil(delta)


func _shoot() -> void:
	fire()
	
	var ammo := ammo_scene.instantiate()
	add_child(ammo)
	
	ammo.global_position = ammo_initial_position.global_position
	ammo.damage = particle_damage
	ammo.direction = -global_transform.basis.z
