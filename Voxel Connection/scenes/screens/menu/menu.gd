extends Control

func start() -> void:
	Singleton.level_current = 1
	
	get_tree().change_scene_to_file("res://scenes/scenarios/World/world.tscn")

func credits() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/credits/credits.tscn")

func exit() -> void:
	get_tree().quit()

func _on_play_pressed() -> void:
	Transition.start(func(): start())

func _on_credits_pressed() -> void:
	Transition.start(func(): credits())

func _on_exit_pressed():
	Transition.start(func(): exit())
