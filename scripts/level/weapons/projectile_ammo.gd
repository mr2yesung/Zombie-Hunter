extends Area3D


const EXPLOSION_ANIMATION_NAME = "explosion"

@export var projectile_speed: float
@export var explosion_particle: PackedScene

var damage: int
var direction: Vector3:
	set(value):
		direction = value.normalized()


func _physics_process(delta: float) -> void:
	position += direction * delta * projectile_speed


func _on_body_entered(body: Node3D) -> void:
	if body is Enemy or body is BrokableProps:
		body.health -= damage
	
	explode()


func _on_ammo_life_timer_timeout() -> void:
	explode()


func explode() -> void:
	var particle := explosion_particle.instantiate()
	get_parent().add_child(particle)
	particle.global_position = global_position
	
	queue_free()
