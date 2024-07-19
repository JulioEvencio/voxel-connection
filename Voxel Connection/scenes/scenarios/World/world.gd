extends Node2D

var map : Array = []

func _ready() -> void:
	pass

func _process(_delta : float) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
