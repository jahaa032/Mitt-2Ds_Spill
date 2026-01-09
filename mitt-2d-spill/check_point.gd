extends Area2D

var check_reached: bool = false

@onready var anim = $AnimatedSprite2D
@onready var ui_control =  $"../Control"

func _ready():
	anim.play("CheckPoint_Red")

func _on_body_entered(body: Node2D) -> void:
	check_reached = true
	body.last_checked = position
	anim.play("CheckPoint_Green")
	ui_control.add_score(200)
