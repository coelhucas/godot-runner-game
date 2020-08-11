extends Control

func _on_Play_pressed():
	get_tree().change_scene("res://src/Scenes/Game/Game.tscn")

func _on_Credits_pressed():
	get_tree().change_scene("res://src/Scenes/Credits/Credits.tscn")

func _on_Quit_pressed():
	get_tree().quit()
