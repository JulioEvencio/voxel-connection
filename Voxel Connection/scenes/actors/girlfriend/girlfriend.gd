extends CharacterBody2D
class_name Girlfriend

var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta : float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()
