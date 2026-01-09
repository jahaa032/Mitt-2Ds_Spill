extends CharacterBody2D

const SPEED = 120
var direction = 1
var is_attacking = false  

@onready var ray_cast_right: RayCast2D = $RayCastRight
@onready var ray_cast_left: RayCast2D = $RayCastLeft
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_timer: Timer = $AttackTimer  
@onready var player_detection: Area2D = $PlayerDetection  # New detection area

func _process(delta: float) -> void:
	if not is_attacking:  # Only move if not attacking
		if ray_cast_right.is_colliding():
			direction = -1
			animated_sprite.flip_h = true
		if ray_cast_left.is_colliding():
			direction = 1
			animated_sprite.flip_h = false

		position.x += direction * SPEED * delta

#func attack():
	#if is_attacking:  # Prevent attacking multiple times at once
		#return  
#
	#is_attacking = true
	#animated_sprite.play("attack")  # Play attack animation
	#attack_timer.start(0.5)  # Attack lasts 0.5 seconds
#
#func _on_AttackTimer_timeout():
	#is_attacking = false  # Allow movement again
	#animated_sprite.play("idle")  # Reset animation
#
##  Detect when player is close
#func _on_PlayerDetection_area_entered(area: Area2D) -> void:
	#if area.is_in_group("Player"):
		#attack()  # Start attack when player is close
#
#func _on_SwordHitbox_area_entered(area: Area2D) -> void:
	#if area.is_in_group("Player"):  
		#area.get_parent().take_damage()  
