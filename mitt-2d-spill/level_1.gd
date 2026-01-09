extends Node2D

@onready var camera = $Player/Camera2D  # Adjust to match your Camera2D node path
@onready var ui_control = $Control  # Adjust to match your UI node path
@onready var mystery_box = $MysteryBox

@onready var heartsContainer = $CanvasLayer/heartsContainer

var CoinScene= preload("res://coin.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#mystery_box.visible = false
	heartsContainer.set_MaxHearts(ui_control.lives)
	heartsContainer.updateHearts(ui_control.lives)
	ui_control.healthChanged.connect(heartsContainer.updateHearts )
	var num_coins = 4
	
	for x in range(num_coins):
		for y in range(num_coins - 1):
			var coin_instance = CoinScene.instantiate()
			coin_instance.position = Vector2(-1350 + 100 * x, 350 + 75 * y)
			add_child(coin_instance)
			
	for x in range(num_coins):
		for y in range(num_coins - 2):
			var coin_instance = CoinScene.instantiate()
			coin_instance.position = Vector2(4448 + 100 * x, 1665 + 75 * y)
			add_child(coin_instance)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ui_control.global_position = camera.global_position - (get_viewport_rect().size / 2)
