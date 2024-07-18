extends Node3D


signal zombie_die

@export var death_sound_player: AudioStreamPlayer3D


func die_animation_finished() -> void:
	zombie_die.emit()


func play_death_sound() -> void:
	death_sound_player.play(0.0)
