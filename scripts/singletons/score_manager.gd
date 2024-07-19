extends Node


signal score_changed

var current_score: int = 0:
	set(value):
		current_score = value
		score_changed.emit()
var highest_score: int = 0:
	set(value):
		highest_score = value
		score_changed.emit()
const SCORE_FILE := "user://score.data"


func _ready() -> void:
	load_highest_score()


func load_highest_score() -> void:
	var file := FileAccess.open(SCORE_FILE, FileAccess.READ)
	if file:
		highest_score = file.get_var()
		file.close()


func reset_game() -> void:
	current_score = 0


func save_highest_score() -> void:
	highest_score = max(current_score, highest_score)
	
	var file := FileAccess.open(SCORE_FILE, FileAccess.WRITE)
	if file:
		file.store_var(highest_score)
		file.close()
