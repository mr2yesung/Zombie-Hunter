extends Node3D


signal zombie_die


func die_animation_finished() -> void:
	zombie_die.emit()
