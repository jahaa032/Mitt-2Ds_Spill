extends CharacterBody2D

@export var speed: float = 100
var direction: int = 1  # 1 = Right, -1 = Left

@onready var anim_player: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void: 
	if not is_on_floor():
		velocity += get_gravity() * delta
	# Move AI in the current direction
	velocity.x = direction * speed
	move_and_slide()

	# Play walking animation if moving
	if velocity.x != 0:
		anim_player.play("walk")
		
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
		
		
		
		
