extends CharacterBody2D

var is_moving_left = true

var gravity = 10

var speed = 32

func _ready():
	$AnimatedSprite2D.play("walk")
	
func _process(delta):
	move_character()
	
func move_character():
	velocity.x = -speed if is_moving_left else speed 
	velocity.y += gravity
	
func detect_turn_around():
	if not $RayCast2D.is_colliding() and is_on_floor():
		is_moving_left = !is_moving_left
		scale.x = -scale.x
	
