extends LeftMovingObject

const POSITION_OFFSET: int = 64
const MINIMUM_OPACITY: float = 0.6

func _ready() -> void:
	self.destroy_on_leave_screen = false
	var cloud_id: int = randi() % 3
	var custom_opacity = clamp(randf(), MINIMUM_OPACITY, 1)
	modulate.a = custom_opacity
	$AnimationPlayer.play(str(cloud_id))

func _process(delta: float) -> void:
	if global_position.x < -POSITION_OFFSET:
		global_position.x = 640 + POSITION_OFFSET
	pass
