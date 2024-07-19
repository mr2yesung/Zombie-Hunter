class_name Player
extends CharacterBody3D


const SPEED := 7.0
const FALL_MULTIPLIER := 2.5
const DECELERATION_SPEED := 50.0
const JUMP_VELOCITY := 5.0
const MAX_STAMINA := 50.0
const STAMINA_USAGE_RATE := 20.0
const STAMINA_RECOVERY_RATE := 5.0

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var mouse_motion := Vector2.ZERO
var mouse_sensitivity := 0.001 # TODO: add to options?
var stamina: float = MAX_STAMINA:
	set(value):
		stamina = clampf(value, 0.0, MAX_STAMINA)

@onready var camera_pivot: Node3D = $CameraPivot
@onready var state_machine: StateMachine = $StateMachine
@onready var playback: AnimationNodeStateMachinePlayback = $AnimationTree["parameters/playback"]
@onready var stamina_bar: ProgressBar = $StatsUI/StaminaBarMargin/StaminaBar
@onready var ammo_label: Label = $StatsUI/AmmoMargin/AmmoLabel


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(_delta: float) -> void:
	stamina_bar.value = stamina / MAX_STAMINA * 100.0


func _physics_process(delta: float) -> void:
	# rotation
	rotate_y(mouse_motion.x)
	
	camera_pivot.rotate_x(mouse_motion.y)
	camera_pivot.rotation_degrees.x = clampf(camera_pivot.rotation_degrees.x, -70.0, 70.0)
	
	# reset mouse motion value after rotation
	mouse_motion = Vector2.ZERO
	
	if state_machine.current_state:
		state_machine.current_state._fixed_update(delta)
	
	move_and_slide()


func _input(event: InputEvent) -> void:
	# rotation
	if event is InputEventMouseMotion:
		mouse_motion = -event.relative * mouse_sensitivity
	
	# for test purpose
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func get_movement_direction() -> Vector3:
	var input_direction := Input.get_vector("move_left", "move_right", "move_front", "move_back")
	return (transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()


func move(movement_direction: Vector3, speed_multiplier: float) -> void:
	velocity.x = movement_direction.x * SPEED * speed_multiplier
	velocity.z = movement_direction.z * SPEED * speed_multiplier


func decrease_speed(delta: float) -> void:
	velocity.x = move_toward(velocity.x, 0, DECELERATION_SPEED * delta)
	velocity.z = move_toward(velocity.z, 0, DECELERATION_SPEED * delta)


func fall(delta: float) -> void:
	if velocity.y >= 0:
		velocity.y -= gravity * delta
	else:
		# smooth fall with faster falling
		velocity.y -= gravity * delta * FALL_MULTIPLIER


func recover_stamina(delta: float) -> void:
	stamina += STAMINA_RECOVERY_RATE * delta


func use_stamina(delta: float) -> void:
	stamina -= STAMINA_USAGE_RATE * delta


func jump() -> void:
	velocity.y = JUMP_VELOCITY
