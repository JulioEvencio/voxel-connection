extends StaticBody2D
class_name Block

@export var block_type : String
@export var can_put_block : bool

@onready var texture_rect : TextureRect = get_node("TextureRect")
@onready var collision_shape_2D : CollisionShape2D = get_node("CollisionShape2D")

var player : Player

func _ready() -> void:
	player = get_tree().get_nodes_in_group("player")[0]

func _physics_process(_delta : float) -> void:
	if Input.is_action_just_pressed("put_block") and texture_rect.get_global_rect().has_point(get_global_mouse_position()):
		put_block()
	
	if Input.is_action_just_pressed("remove_block") and texture_rect.get_global_rect().has_point(get_global_mouse_position()):
		remove_block()

func put_block() -> void:
	if can_put_block and player.item_current < player.inventory.size() and player.inventory[player.item_current][2]:
		block_type = player.inventory[player.item_current][0]
		texture_rect.texture = load(player.inventory[player.item_current][1])
		collision_shape_2D.disabled = false
		can_put_block = false

func remove_block() -> void:
	if player.item_current < player.inventory.size() and block_type == player.inventory[player.item_current][0]:
		player.add_block_to_inventory(self)
		block_type = "Sky"
		texture_rect.texture = load("res://assets/2D/other/skybox_top.png")
		collision_shape_2D.disabled = true
		can_put_block = true

func _on_sprite_2d_mouse_entered() -> void:
	texture_rect.modulate = Color.GRAY

func _on_sprite_2d_mouse_exited() -> void:
	texture_rect.modulate = Color.WHITE
