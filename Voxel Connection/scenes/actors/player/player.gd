extends CharacterBody2D
class_name Player

signal next_level

@onready var item_audio : AudioStreamPlayer = get_node("ItemAudio")

const SPEED : float = 300.0
const JUMP_VELOCITY : float = -600.0

var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")

var slots : Array
var inventory : Array = []
var item_current : int = 0
var can_next_level : bool = true

func _ready() -> void:
	slots = get_tree().get_nodes_in_group("slots")
	
	for i in slots.size():
		slots[i].modulate = Color.DARK_SLATE_GRAY

func _physics_process(delta : float) -> void:
	move(delta)
	update_item_current()

func move(delta : float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	var direction : float = Input.get_axis("move_left", "move_right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()

func update_item_current() -> void:
	slots[item_current].modulate = Color.DARK_SLATE_GRAY
	
	update_item_current_mouse()
	update_item_current_key()
	
	slots[item_current].modulate = Color.WHITE

func update_item_current_mouse() -> void:
	if Input.is_action_just_pressed("mouse_wheel_up"):
		item_current += 1
		
		if item_current >= 6:
			item_current = 0
	elif Input.is_action_just_pressed("mouse_wheel_down"):
		item_current -= 1
		
		if item_current <= -1:
			item_current = 5

func update_item_current_key() -> void:
	if Input.is_action_just_pressed("key_1"):
		item_current = 0
	elif Input.is_action_just_pressed("key_2"):
		item_current = 1
	elif Input.is_action_just_pressed("key_3"):
		item_current = 2
	elif Input.is_action_just_pressed("key_4"):
		item_current = 3
	elif Input.is_action_just_pressed("key_5"):
		item_current = 4
	elif Input.is_action_just_pressed("key_6"):
		item_current = 5

func add_block_to_inventory(block : Block) -> void:
	if not inventory.has([block.block_type, block.get_node("TextureRect").texture.resource_path, true, false]):
		slots[inventory.size()].get_node("TextureRect").set_texture(load(block.get_node("TextureRect").texture.resource_path))
		inventory.push_back([block.block_type, block.get_node("TextureRect").texture.resource_path, true, false])

func _on_area_2d_body_entered(body : PhysicsBody2D) -> void:
	if body is Item:
		slots[inventory.size()].get_node("TextureRect").set_texture(load(body.get_node("Sprite2D").texture.resource_path))
		inventory.push_back([body.item_name, body.get_node("Sprite2D").texture.resource_path, false, true])
		body.queue_free()
		item_audio.play()
	elif body is Girlfriend and can_next_level:
		can_next_level = false
		next_level.emit()
