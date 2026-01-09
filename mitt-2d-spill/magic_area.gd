extends Area2D

var speed = 1000
var velocity
var direction = 1

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var ui_control =  $"../Control"
@onready var timer = $Timer

func _ready() -> void:
	connect("area_entered", Callable(self, "_on_area_entered"))
	$Timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("Magic"):
		animated_sprite.play("fireball")
		
	if direction == 1:
		velocity = Vector2(-1, 0) * speed * delta
		$Magic/CPUParticles2D.gravity.x = 3000
		animated_sprite.flip_h = true
	else:
		velocity = Vector2(1, 0) * speed * delta
		$Magic/CPUParticles2D.gravity.x = -3000
		animated_sprite.flip_h = false
		
	position += velocity

func _on_area_entered(area: Area2D) -> void:
	print("Collided with: ", area)  # Debugging
	if area.is_in_group("Enemy"):  # Ensure correct group name
		var enemy = area.get_parent()  # Double-check this is the actual enemy node
		print("Deleting Enemy: ", enemy)
		enemy.queue_free()
		ui_control.add_score(100)
		queue_free()
		print("Magic hit! Deleting both.")

func _on_timer_timeout() -> void:
	queue_free()
