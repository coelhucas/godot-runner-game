extends Node

enum Spawn {
	GROUND,
	AIR
}

onready var ground_obstacle: PackedScene = preload("res://src/Scenes/GroundObstacle/GroundObstacle.tscn")
onready var air_obstacle: PackedScene = preload("res://src/Scenes/AirObstacle/AirObstacle.tscn")

const ZERO_PADS: int = 5
const INITIAL_GAME_SPEED: int = 200
const INITIAL_SPAWN_TIMER: float = 2.0
const INITIAL_DIFFICULT_TIMER: float = 3.0
const INITIAL_SCORE_TIMER: float = 0.5
const OBSTACLE_GROUP: String = "obstacle"

var high_score: int
var score: int
var game_speed: float = 200
var modifier: float = 0.05

func spawn_obstacle() -> void:
	var spawn_id: int = randi() % 2
	var spawn_point: Node
	var new_obstacle: Node2D
	
	if spawn_id == Spawn.GROUND:
		spawn_point = $World/SpawnPoints/Ground
		new_obstacle = ground_obstacle.instance()
	else:
		spawn_point = $World/SpawnPoints/Air
		new_obstacle = air_obstacle.instance()
	
	new_obstacle.global_position = spawn_point.global_position
	new_obstacle.speed = game_speed
	new_obstacle.game_manager = self
	$World/Obstacles.add_child(new_obstacle)

func reset_game() -> void:
	for obstacle in $World/Obstacles.get_children():
		obstacle.queue_free()
	
	game_speed = INITIAL_GAME_SPEED
	if score > high_score:
		high_score = score
		$"UI/HI-Score".number = str(high_score).pad_zeros(ZERO_PADS)
	
	$SpawnTimer.wait_time = INITIAL_SPAWN_TIMER
	$DifficultTimer.wait_time = INITIAL_DIFFICULT_TIMER
	$ScoreTimer.wait_time = INITIAL_SCORE_TIMER
	score = 0
	$UI/Score.number = "0".pad_zeros(ZERO_PADS)


func _on_SpawnTimer_timeout() -> void:
	spawn_obstacle()

func _on_ScoreTimer_timeout() -> void:
	score += 1
	$UI/Score.number = str(score).pad_zeros(ZERO_PADS)


func _on_DifficultTimer_timeout():
	game_speed += game_speed * modifier
	$SpawnTimer.wait_time -= $SpawnTimer.wait_time * modifier
