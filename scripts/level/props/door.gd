class_name BrokableProps
extends StaticBody3D


@export var max_health := 50.0

var health := max_health:
	set(value):
		health = value
		
		if health <= 0.0:
			queue_free()
		elif health <= max_health / 2.0:
			door_broken_mesh.visible = true
			door_mesh.visible = false

@onready var door_mesh: Node3D = $door
@onready var door_broken_mesh: Node3D = $door_broken


func _ready() -> void:
	door_broken_mesh.visible = false
