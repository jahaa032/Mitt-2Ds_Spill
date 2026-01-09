extends Area2D

@onready var timer: Timer = $Timer

@onready var ui_control = $"/root/Node2D/Control"
@onready var player = $"/root/Node2D/Player"

func _on_body_entered(body: Node2D) -> void:
	ui_control.lose_life()
	Engine.time_scale = 0.5
	var tween = create_tween()
	tween.tween_property(player, "position:y", position.y - 1000, 0.1)
	tween.tween_property(player, "rotation_degrees", 360, 0.3)
	tween.tween_callback(Callable(self, "_vanish"))
	#print("You died!")
	timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	if ui_control.lives == 0:
		get_tree().reload_current_scene()
	#elif get_parent().name == "Node2D": 
	else:
		player.position = player.last_checked
		player.remove_wings()
