extends State


const HIGH_FALL_TIME_THRESHOLD := 1.0

@export var footstep_sound_player: Node3D

var high_fall := false

@onready var fall_time_timer: Timer = $FallTimeTimer


func _enter() -> void:
	# idle animation has no sound effect, which can be used for falling state
	player.playback.travel("idle")
	
	high_fall = false
	fall_time_timer.start(HIGH_FALL_TIME_THRESHOLD)


func _fixed_update(delta: float) -> void:
	if player.is_on_floor():
		transition.emit("idle")
	
	player.fall(delta)
	
	player.recover_stamina(delta)


func _exit() -> void:
	fall_time_timer.stop()
	
	# play footstep sound for landing to ground
	if high_fall:
		footstep_sound_player.play_run_sound()
	else:
		footstep_sound_player.play_walk_sound()


func _on_fall_time_timer_timeout() -> void:
	high_fall = true
