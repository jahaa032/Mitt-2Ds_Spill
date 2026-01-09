extends CharacterBody2D

var gravity = 10

var speed = 32

func _ready():
	$AnimationPlayer.play("walk")
