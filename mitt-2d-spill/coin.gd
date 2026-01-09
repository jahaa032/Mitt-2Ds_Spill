extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	body.collect_coin()
	var tween = create_tween()
	tween.tween_property(self, "position:y", position.y - 150, 1)
	tween.tween_property(self, "scale", Vector2(2,2), 0.5)
	tween.tween_callback(Callable(self, "_vanish"))
	animation_player.play("pickup")
	
