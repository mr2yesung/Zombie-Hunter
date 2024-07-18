extends CharacterBody3D


# AGGRO_RANGE = 30.0
const AGGRO_RANGE_SQUARED := 900.0
const ZOMBIE_RUN_ANIMATION_NAME := "zombie_animation_run"
const GAME_OVER_DISTANCE_SQUARED := 7.0
const MINIMUM_LOOKAT_DISTANCE_SQUARED := 0.0001

@export var walk_speed := 5.0
@export var run_speed := 10.0
@export var animation_tree: AnimationTree

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var provoked := false

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var player: Player = get_tree().get_first_node_in_group("player") as Player
@onready var playback: AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]


func _process(_delta: float) -> void:
	# ensure target position is set before calling get_next_path_position at the beginning
	navigation_agent_3d.target_position = player.global_position


func _physics_process(delta: float) -> void:
	var next_position = navigation_agent_3d.get_next_path_position()
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var direction := global_position.direction_to(next_position)
	var distance := global_position.distance_squared_to(player.global_position)
	
	if distance <= GAME_OVER_DISTANCE_SQUARED:
		# TODO: add game over
		print("player died")
	
	if not provoked and distance <= AGGRO_RANGE_SQUARED:
		provoked = true
		playback.travel(ZOMBIE_RUN_ANIMATION_NAME)
	
	var speed := run_speed if provoked else walk_speed
	
	velocity.x = direction.x * speed
	velocity.z = direction.z * speed
	
	var look_at_direction := Vector3(direction.x, 0.0, direction.z)
	
	if look_at_direction.length_squared() > MINIMUM_LOOKAT_DISTANCE_SQUARED:
		look_at(look_at_direction + global_position, Vector3.UP, true)
	
	move_and_slide()
