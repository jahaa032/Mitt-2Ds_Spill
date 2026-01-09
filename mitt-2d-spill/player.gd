extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
var anim

var has_wings: bool = false

var last_checked: Vector2

@onready var ui_control = $"../Control"

var CoinScene= preload("res://coin.tscn")

func _ready():
	anim = $AnimatedSprite2D
	last_checked = position

func _physics_process(delta):
	var move_direction = Vector2.ZERO
	var is_crouching = false
	
	if has_wings:
		#ui_control.lose_wings(delta)
		if ui_control.wings_time == 0:
			has_wings = false
	
	if Input.is_action_pressed("move_right"):
		move_direction.x = 1
	elif Input.is_action_pressed("move_left"):
		move_direction.x = -1
	elif Input.is_action_pressed("ui_down"):
		is_crouching = true
	elif Input.is_action_pressed("ui_up"):
		move_direction.y = -1
		
	velocity.x = move_toward(velocity.x, move_direction.x * SPEED, 5)
	velocity.y = move_toward(velocity.y, move_direction.y * SPEED, 5)
	move_and_slide()
	
	if is_crouching:
		anim.play("crouch")
	elif has_wings:
		anim.play("wings")
	elif velocity.y != 0:
		anim.play("jump")
	elif velocity.x !=0:
		anim.play("run")
	else:
		anim.play("idle")
	
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
		elif has_wings:
			velocity.y = JUMP_VELOCITY * 0.8
			ui_control.lose_wings(1)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.x < 0:
			anim.flip_h = true
		else:
			anim.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if Input.is_action_just_pressed("Magic"):
		var magicNode = load("res://magic_area.tscn")
		var newMagic = magicNode.instantiate()
		if $AnimatedSprite2D.flip_h == false:
			newMagic.direction = -1
		else:
			newMagic.direction = 1
		newMagic.set_position(%MagicSpawnPoint.global_transform.origin)
		get_parent().add_child(newMagic)



func collect_coin():
	ui_control.add_coin()
	#print("Coins collected: ", coins_collected)
	
func add_wings():
	has_wings = true
	ui_control.wings_time = 20
	ui_control.update_ui()
	
	var num_coins = 4
	
	for x in range(num_coins):
		for y in range(num_coins - 1):
			var coin_instance = CoinScene.instantiate()
			coin_instance.position = Vector2(5832 + 100 * x, 936 + 75 * y)
			call_deferred("add_child", coin_instance)
			print("Blue coins")
	
func remove_wings():
	has_wings = false
	ui_control.wings_time = 0
	ui_control.update_ui()
