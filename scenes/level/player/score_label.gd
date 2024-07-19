extends Label


func _ready() -> void:
	ScoreManager.score_changed.connect(_on_score_changed)
	
	_on_score_changed()


func _on_score_changed() -> void:
	text = "Score: " + str(ScoreManager.current_score) + " / High: " + str(ScoreManager.highest_score)
