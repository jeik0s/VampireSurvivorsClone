extends CharacterBody2D

@export var movment_speed = 20.0
@export var hp = 10;
@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer


@onready var player = get_tree().get_first_node_in_group("player")

func _process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movment_speed
	move_and_slide()
	animation_player.play("walk")
	if direction.x > 0.1:
		sprite.flip_h = true;
	elif direction.x -0.1:
		sprite.flip_h = false;



func _on_hurt_box_hurt(damage):
	hp -= damage
	if hp <= 0:
		queue_free()
