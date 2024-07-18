extends Weapon


@export var ammo_scene: PackedScene
@export var particle_damage: int
## Whether the ammo will spread as shotgun
@export var spread := false
## Spread angle when the ammo spreads
@export var max_spread_angle := 45.0
@export var particle_per_ammo := 1

@onready var ammo_initial_position: Marker3D = $Marker3D


func _process(delta: float) -> void:
	if cooldown_timer.is_stopped():
		if Input.is_action_just_pressed("fire"):
			_shoot()
	
	recover_recoil(delta)


func _shoot() -> void:
	fire()
	
	for i in particle_per_ammo:
		var ammo := ammo_scene.instantiate()
		add_child(ammo)
		
		ammo.global_position = ammo_initial_position.global_position
		ammo.damage = particle_damage
		
		var base_direction = -global_transform.basis.z
		# spread in horizontal direction randomly
		ammo.direction = base_direction.rotated(Vector3.UP, deg_to_rad(randf_range(-max_spread_angle, max_spread_angle))) if spread else base_direction
