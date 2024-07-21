extends Control

func menu() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/menu/menu.tscn")

func _on_button_pressed() -> void:
	Transition.start(func(): menu())
