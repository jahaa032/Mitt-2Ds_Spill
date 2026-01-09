extends RigidBody2D

@export var speed: float = 100
var direction: int = 1  # 1 = Right, -1 = Left

@onready var sprite = $Sprite2D  # Reference the sprite correctly

func _ready():
	freeze = false  # Ensure the rigid body isn't frozen
	gravity_scale = 1  # Adjust if needed
	angular_velocity = 0  # Prevent spinning
	set_deferred("angular_damp", 1000)  # Strong damping to stop rotation

func _physics_process(delta: float) -> void:
	linear_velocity.x = direction * speed  # Move automatically

func _integrate_forces(state):
	var collision = move_and_collide(Vector2(direction * speed * state.get_step(), 0))
	
	if collision:
		direction *= -1  # Reverse direction
		if sprite:
			sprite.flip_h = direction == -1
