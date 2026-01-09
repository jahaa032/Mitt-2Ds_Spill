extends CharacterBody2D


const SPEED = 120

var direction = 1

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

var health = 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if health <= 0:
		$Killzone/CollisionShape2D.disabled = true
		set_physics_process(false)
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
		
	if health <= 0: animated_sprite.play("death")
	
	position.x += direction * SPEED * delta

func _on_get_damage_box_body_entered(body: Node2D) -> void:
	if "player" in body.name:
		health -= 1

func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "death":
		queue_free()
