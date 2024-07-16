extends Node3D


@onready var main_screen: Control = $MainScreen
@onready var options_screen: Control = $OptionsScreen
@onready var weapon_select_screen: Control = $WeaponSelectScreen


func _ready() -> void:
	options_screen.visible = false
	weapon_select_screen.visible = false
	main_screen.visible = true


func _on_main_to_options() -> void:
	main_screen.visible = false
	options_screen.visible = true


func _on_options_to_main() -> void:
	options_screen.visible = false
	main_screen.visible = true


func _on_main_to_select() -> void:
	main_screen.visible = false
	weapon_select_screen.visible = true


func _on_select_to_main() -> void:
	weapon_select_screen.visible = false
	main_screen.visible = true


func _on_start_game() -> void:
	# test
	printt("game start", WeaponManager.player_main_weapon)
