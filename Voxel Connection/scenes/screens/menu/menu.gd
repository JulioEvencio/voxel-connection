extends Control

func start() -> void:
	Singleton.level_current = 1
	
	get_tree().change_scene_to_file("res://scenes/scenarios/World/world.tscn")

func credits() -> void:
	pass

func _on_play_pressed() -> void:
	Transition.start(func(): start())

func _on_credits_pressed() -> void:
	Transition.start(func(): credits())
