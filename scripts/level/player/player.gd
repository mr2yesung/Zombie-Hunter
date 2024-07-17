extends CharacterBody3D


const WALK_SPEED := 7.0
const RUN_SPEED := 15.0
const DECELERATION_SPEED := 50.0
const JUMP_VELOCITY := 5.0
const FALL_MULTIPLIER := 2.5
const MAX_STAMINA := 50.0
const STAMINA_USAGE_RATE := 20.0
const STAMINA_RECOVERY_RATE := 5.0

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var mouse_motion := Vector2.ZERO
var mouse_sensitivity := 0.001 # TODO: add to options?
var is_running := false
var stamina: float = MAX_STAMINA:
	set(value):
		if value <= 0.0:
			is_running = false
		
		stamina = clampf(value, 0.0, MAX_STAMINA)

@onready var camera_pivot: Node3D = $CameraPivot


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _physics_process(delta: float) -> void:
	# rotation
	rotate_y(mouse_motion.x)
	
	camera_pivot.rotate_x(mouse_motion.y)
	camera_pivot.rotation_degrees.x = clampf(camera_pivot.rotation_degrees.x, -70.0, 70.0)
	
	# reset mouse motion value after rotation
	mouse_motion = Vector2.ZERO
	
	# jump
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			velocity.y = JUMP_VELOCITY
	else:
		if velocity.y >= 0:
			velocity.y -= gravity * delta
		else:
			# smooth fall with faster falling
			velocity.y -= gravity * delta * FALL_MULTIPLIER
	
	# run
	var speed := WALK_SPEED
	if is_running:
		speed = RUN_SPEED
		stamina -= STAMINA_USAGE_RATE * delta
	else:
		stamina += STAMINA_RECOVERY_RATE * delta
	
	# movement
	var input_direction := Input.get_vector("move_left", "move_right", "move_front", "move_back")
	var movement_direction := (transform.basis * Vector3(input_direction.x, 0, input_direction.y)).normalized()
	
	if movement_direction != Vector3.ZERO:
		velocity.x = movement_direction.x * speed
		velocity.z = movement_direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, DECELERATION_SPEED * delta)
		velocity.z = move_toward(velocity.z, 0, DECELERATION_SPEED * delta)
	
	move_and_slide()


func _input(event: InputEvent) -> void:
	# rotation
	if event is InputEventMouseMotion:
		mouse_motion = -event.relative * mouse_sensitivity
	
	# run
	if event.is_action_pressed("run"):
		is_running = true
	
	if event.is_action_released("run"):
		is_running = false
	
	# for test purpose
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
