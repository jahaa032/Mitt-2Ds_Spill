extends StaticBody2D

@export var speed: float = 100
var direction: int = 1  # 1 = Right, -1 = Left
var velocity = Vector2.ZERO

@onready var anim_player: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void: 
	velocity.y = 0
	# Move AI in the current direction
	velocity.x = direction * speed

	# Play walking animation if moving
	if velocity.x != 0:
		anim_player.play("move")
		
	#check for collision
	if is_on_wall():
		direction = -direction
		
		
	if direction:
		velocity.x = direction * speed
		if velocity.x < 0:
			anim_player.flip_h = true
		else:
			anim_player.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	move_and_slide()
