class_name StateMachine
extends Node


@export var current_state: State

var states: Dictionary = {}


func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transition.connect(_on_state_transition)


func _on_state_transition(new_state_name: String) -> void:
	var new_state: State = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state._exit()
	
	new_state._enter()
	
	current_state = new_state
