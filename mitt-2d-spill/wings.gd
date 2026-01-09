extends Area2D

@onready var ui_control = $"../Control"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("wings")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_body_entered(body: Node) -> void:
	print("wings")
	body.add_wings()
	
	queue_free()
	
