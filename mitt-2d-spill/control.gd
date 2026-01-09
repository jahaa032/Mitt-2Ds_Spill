extends Control

signal healthChanged

var coins = 0
var lives = 3
var wings_time: float = 0.0
var total_score = 0

@onready var coins_label = $CoinsLabel
@onready var lives_label = $LivesLabel
@onready var wings_label = $WingsLabel
@onready var score_label = $ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_ui()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func update_ui():
	coins_label.text = "Coins: %d" % coins
	lives_label.text = "Lives: %d" % lives
	score_label.text = "Score: %d" % total_score
	if wings_time > 0:
		wings_label.text = "Wings: %d" % wings_time
	else:
		wings_label.text = ""
	
func add_coin():
	coins += 1
	add_score(10)
	if coins >= 20:
		lives += 1
		coins = 0
		healthChanged.emit(lives)
	update_ui() 
	
func lose_life():
	lives -= 1
	healthChanged.emit(lives)
	update_ui()
	
func lose_wings(delta):
	wings_time -= delta
	if wings_time < 0:
		wings_time = 0
	update_ui()
	
func add_score(score):
	total_score += score
	update_ui()
	
	
