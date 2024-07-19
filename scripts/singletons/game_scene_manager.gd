extends Node


@export var loading_scene: PackedScene
@export var main_menu_scene: PackedScene


func move_to_level() -> void:
	get_tree().change_scene_to_packed(loading_scene)


func move_to_menu() -> void:
	get_tree().change_scene_to_packed(main_menu_scene)
