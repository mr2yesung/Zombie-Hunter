extends Node3D


@export var explosion_damage: int


func _on_explosion_body_entered(body: Node3D) -> void:
	if body is Enemy or body is BrokableProps:
		body.health -= explosion_damage
