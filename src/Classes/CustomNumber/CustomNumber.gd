extends Node2D

export(PackedScene) var number_scene: PackedScene

export(String) var number: String = "00000"
export(int) var spacing: int = 2
var current_value: String = "00000"

func _process(delta) -> void:
	if number != current_value:
		var accumulator: int = 0
		for child in get_children():
			child.queue_free()
			
		for digit in str(number):
			var fixed_digit: int = int(digit)
			var digit_node: Sprite = number_scene.instance()
			add_child(digit_node)
			digit_node.global_position = global_position
			digit_node.global_position.x += accumulator * spacing
			digit_node.get_node("AnimationPlayer").play(digit)
			print("Digit %s" % digit)
			accumulator += 1
		number = current_value
	pass
