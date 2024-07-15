extends Node


@onready var click_sound_player: AudioStreamPlayer = $ClickSoundPlayer


func play_click():
	click_sound_player.play()
