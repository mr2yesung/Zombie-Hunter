extends Node3D


@onready var walk_sound_player: AudioStreamPlayer3D = $WalkSoundPlayer
@onready var run_sound_player: AudioStreamPlayer3D = $RunSoundPlayer


func play_walk_sound() -> void:
	walk_sound_player.pitch_scale = randf_range(0.8, 1.2)
	walk_sound_player.play(0.0)


func play_run_sound() -> void:
	run_sound_player.pitch_scale = randf_range(0.9, 1.3)
	run_sound_player.play(0.0)
