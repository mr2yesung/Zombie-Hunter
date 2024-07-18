class_name State
extends Node


signal transition

@export var player: Player

func _enter() -> void:
	pass


func _exit() -> void:
	pass


func _fixed_update(_delta: float) -> void:
	pass


func check_falling() -> void:
	if not player.is_on_floor():
		transition.emit("fall")


func check_idle(movement_direction: Vector3) -> void:
	if movement_direction == Vector3.ZERO:
		transition.emit("idle")


func check_jump() -> void:
	if Input.is_action_just_pressed("jump"):
		player.jump()
