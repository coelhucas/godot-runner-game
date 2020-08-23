extends KinematicBody2D

const NORMAL: Vector2 = Vector2(0, -1)
const JUMP_FORCE: int = -850
const GRAVITY: int = 50

var motion: Vector2
var animation: String = "run"

func _physics_process(delta) -> void:
	motion.y += GRAVITY
	
	if animation != $AnimationPlayer.current_animation:
		$AnimationPlayer.play(animation)
	
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		motion.y = JUMP_FORCE
	
	if Input.is_action_pressed("ui_down") and is_on_floor():
		animation = "slide"
		$UpperBody.disabled = true
	elif $UpperBody.disabled:
		$UpperBody.disabled = false
		animation = "run"
		
	motion = move_and_slide(motion, NORMAL)
