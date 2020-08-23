extends Area2D
class_name LeftMovingObject

const OFFSET: int = 32

var speed: int = 200
var direction: Vector2 = Vector2.LEFT
var game_manager: Node
var destroy_on_leave_screen: bool = true

func _ready() -> void:
	connect("body_entered", self, "_on_body_entered")

func _physics_process(delta: float) -> void:
	if global_position.x + OFFSET < 0 and destroy_on_leave_screen:
		queue_free()
	
	if is_instance_valid(game_manager) and game_manager.game_speed != speed:
		pass
	
	global_position.x -= speed * delta

func _on_body_entered(body: PhysicsBody2D) -> void:
	game_manager.reset_game()
