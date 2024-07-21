extends CanvasLayer

@onready var animation_player : AnimationPlayer = get_node("AnimationPlayer")

var lambda : Callable

func _ready() -> void:
	animation_player.play("fade_out")

func start(callable : Callable) -> void:
	lambda = callable
	animation_player.play("fade_in")

func call_lambda() -> void:
	lambda.call()
	animation_player.play("fade_out")

func _on_animation_player_animation_finished(anim_name : String) -> void:
	match anim_name:
		"fade_in":
			call_deferred("call_lambda")
