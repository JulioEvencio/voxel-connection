extends Node2D
class_name World

@onready var label : Label = get_node("Label")

@onready var block_base_scene : PackedScene = preload("res://scenes/blocks/block_base/block.tscn")
@onready var block_dirt_scene : PackedScene = preload("res://scenes/blocks/dirt/dirt.tscn")
@onready var block_wood_scene : PackedScene = preload("res://scenes/blocks/wood/wood.tscn")
@onready var block_stone_scene : PackedScene = preload("res://scenes/blocks/stone/stone.tscn")
@onready var block_sand_scene : PackedScene = preload("res://scenes/blocks/sand/sand.tscn")

@onready var pick_scene : PackedScene = preload("res://scenes/items/pick/pick.tscn")
@onready var axe_scene : PackedScene = preload("res://scenes/items/axe/axe.tscn")
@onready var shovel_scene : PackedScene = preload("res://scenes/items/shovel/shovel.tscn")

var map : Array

func _ready() -> void:
	map = Singleton.levels[Singleton.level_current]
	
	label.text = Singleton.levels_texts[Singleton.level_current]
	
	label.position.x = 100
	label.position.y = 100
	
	build_world()

func _physics_process(_delta : float) -> void:
	if Input.is_action_just_pressed("restart"):
		Transition.start(func(): restart())
	if Input.is_action_just_pressed("enter"):
		Transition.start(func(): menu())

func restart() -> void:
	get_tree().reload_current_scene()

func menu() -> void:
	get_tree().change_scene_to_file("res://scenes/screens/menu/menu.tscn")

func build_world() -> void:
	for i in map.size():
		for j in map[i].size():
			var body : PhysicsBody2D
			
			match map[i][j]:
				'D':
					body = block_dirt_scene.instantiate()
				'W':
					body = block_wood_scene.instantiate()
				'S':
					body = block_stone_scene.instantiate()
				'B':
					body = block_sand_scene.instantiate()
				'P':
					body = block_base_scene.instantiate()
					
					$Player.position.x = 128 * j
					$Player.position.y = 128 * i
				'G':
					body = block_base_scene.instantiate()
					
					$Girlfriend.visible = true
					$Girlfriend.position.x = 128 * j
					$Girlfriend.position.y = 128 * i
				'O':
					var item : Item = pick_scene.instantiate()
					
					item.position.x = 128 * j
					item.position.y = 128 * i
					
					add_child(item)
					
					body = block_base_scene.instantiate()
				'U':
					var item : Item = shovel_scene.instantiate()
					
					item.position.x = 128 * j
					item.position.y = 128 * i
					
					add_child(item)
					
					body = block_base_scene.instantiate()
				'A':
					var item : Item = axe_scene.instantiate()
					
					item.position.x = 128 * j
					item.position.y = 128 * i
					
					add_child(item)
					
					body = block_base_scene.instantiate()
				_:
					body = block_base_scene.instantiate()
			
			body.position.x = 128 * j
			body.position.y = 128 * i
			
			add_child(body)

func _on_player_next_level() -> void:
	Singleton.level_current += 1
	Transition.start(func(): restart())
