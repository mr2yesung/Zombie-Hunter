extends Control


const CROSSHAIR_SPREAD_DISTANCE := 2.0
const CROSSHAIR_SPEED := 0.25

@export var player: Player
## Crosshair lines
@export var crosshair_lines: Array[Line2D]


func _process(_delta: float) -> void:
	adjust_crosshair_lines()


func _draw() -> void:
	draw_circle(Vector2.ZERO, 1.0, Color.RED)


func adjust_crosshair_lines() -> void:
	var player_speed := player.get_real_velocity().distance_squared_to(Vector3.ZERO)
	var player_speed_ratio := player_speed / pow(player.WALK_SPEED, 2.0)
	
	crosshair_lines[0].position = lerp(crosshair_lines[0].position, Vector2(0.0, -player_speed_ratio * CROSSHAIR_SPREAD_DISTANCE), CROSSHAIR_SPEED) # Top
	crosshair_lines[1].position = lerp(crosshair_lines[1].position, Vector2(0.0, player_speed_ratio * CROSSHAIR_SPREAD_DISTANCE), CROSSHAIR_SPEED) # Down
	crosshair_lines[2].position = lerp(crosshair_lines[2].position, Vector2(-player_speed_ratio * CROSSHAIR_SPREAD_DISTANCE, 0.0), CROSSHAIR_SPEED) # Left
	crosshair_lines[3].position = lerp(crosshair_lines[3].position, Vector2(player_speed_ratio * CROSSHAIR_SPREAD_DISTANCE, 0.0), CROSSHAIR_SPEED) # Right
