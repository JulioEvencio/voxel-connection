extends StaticBody2D
class_name Block

@onready var texture_rect : TextureRect = get_node("TextureRect")
@onready var collision_shape_2D : CollisionShape2D = get_node("CollisionShape2D")

var new_block : String = "res://assets/2D/tiles/dirt_grass.png"

func _physics_process(_delta : float) -> void:
	if Input.is_action_just_pressed("put_block") and texture_rect.get_global_rect().has_point(get_global_mouse_position()):
		texture_rect.texture = load(new_block)
		collision_shape_2D.disabled = false
	elif Input.is_action_just_pressed("remove_block") and texture_rect.get_global_rect().has_point(get_global_mouse_position()):
		texture_rect.texture = load("res://assets/2D/other/skybox_top.png")
		collision_shape_2D.disabled = true
