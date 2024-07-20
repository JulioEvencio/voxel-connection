extends Node2D

@onready var block_scene : PackedScene = preload("res://scenes/blocks/block_base/block.tscn")

func aasdready() -> void:
	for i in range(10):
		var block : Block = block_scene.instantiate()
		
		block.position.x = 128 * i
		block.position.y = 0
		
		add_child(block)

func _physics_process(_delta : float) -> void:
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
