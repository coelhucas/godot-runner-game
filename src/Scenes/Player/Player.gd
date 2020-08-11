extends KinematicBody2D

const NORMAL: Vector2 = Vector2(0, -1)
const JUMP_FORCE: int = -850
const GRAVITY: int = 50

var motion: Vector2

func _physics_process(delta) -> void:
	motion.y += GRAVITY
	
	if Input.is_action_just_pressed("ui_up"):
		motion.y = JUMP_FORCE
	
	if Input.is_action_pressed("ui_down") and is_on_floor():
		$UpperBody.disabled = true
	elif $UpperBody.disabled:
		$UpperBody.disabled = false
		
	motion = move_and_slide(motion, NORMAL)
