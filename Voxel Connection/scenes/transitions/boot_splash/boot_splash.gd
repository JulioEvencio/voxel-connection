extends Control

func kenney() -> void:
	get_tree().change_scene_to_file("res://scenes/transitions/kenney/kenney.tscn")

func _on_timer_timeout():
	Transition.start(func(): kenney())
