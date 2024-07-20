extends Node3D


const MIN_SPAWN_INTERVAL := 30.0
const MAX_SPAWN_INTERVAL := 60.0

@export var zombie_base: PackedScene
@export var zombie_mutant: PackedScene
@export_range(0.0, 1.0) var mutant_percentage := 0.1

@onready var spawn_timer: Timer = $SpawnTimer
@onready var spawn_position: Marker3D = $SpawnPosition


func spawn_zombie() -> void:
	var random_percentage := randf()
	
	var zombie := instantiate_zombie(random_percentage < mutant_percentage)
	add_child(zombie)
	zombie.global_position = spawn_position.global_position


func instantiate_zombie(is_mutant: bool) -> Node:
	if is_mutant:
		return zombie_mutant.instantiate()
	
	return zombie_base.instantiate()


func _on_spawn_timer_timeout() -> void:
	spawn_zombie()
	
	spawn_timer.start(randf_range(MIN_SPAWN_INTERVAL, MAX_SPAWN_INTERVAL))
