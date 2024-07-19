extends Node


@export var main_menu_scene: PackedScene
@export var level_scene: PackedScene


func move_to_level() -> void:
	get_tree().change_scene_to_packed(level_scene)


func move_to_menu() -> void:
	get_tree().change_scene_to_packed(main_menu_scene)
