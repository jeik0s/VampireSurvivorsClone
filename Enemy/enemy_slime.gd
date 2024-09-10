extends CharacterBody2D

@export var movment_speed = 20.0

@onready var player = get_tree().get_first_node_in_group("player")
@onready var animated_sprite = $AnimatedSprite2D

func _process(_delta):
	animated_sprite.play("walk")
	var move_to = global_position.direction_to(player.global_position)
	if move_to.x > 0.1:
		animated_sprite.flip_h = false;
	elif move_to.x < -0.1:
		animated_sprite.flip_h = true;
	velocity = move_to * movment_speed
	move_and_slide()
	
