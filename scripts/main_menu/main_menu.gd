extends Node3D


@onready var main_screen: Control = $MainScreen
@onready var options_screen: Control = $OptionsScreen


func _ready() -> void:
	main_screen.visible = true
	options_screen.visible = false


func _on_main_to_options() -> void:
	main_screen.visible = false
	options_screen.visible = true


func _on_options_to_main() -> void:
	main_screen.visible = true
	options_screen.visible = false
