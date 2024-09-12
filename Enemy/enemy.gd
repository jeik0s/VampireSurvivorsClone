extends CharacterBody2D

@export var movment_speed = 20.0
@export var hp = 10;
@export var knockback_recovery = 3.5
var knockback = Vector2.ZERO

signal remove_from_array(object)

var death_anim = preload("res://Enemy/explosion.tscn")

@onready var sprite = $Sprite2D
@onready var animation_player = $AnimationPlayer
@onready var snd_hit = $snd_hit


@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movment_speed
	velocity += knockback
	move_and_slide()
	animation_player.play("walk")
	if direction.x > 0.1:
		sprite.flip_h = true;
	elif direction.x -0.1:
		sprite.flip_h = false;

func death():
	emit_signal("remove_from_array",self)
	var enemey_death = death_anim.instantiate()
	enemey_death.scale = sprite.scale
	enemey_death.global_position = global_position
	get_parent().call_deferred("add_child",enemey_death)
	queue_free()

func _on_hurt_box_hurt(damage, angle, knockback_amount):
	hp -= damage
	knockback = angle * knockback_amount
	if hp <= 0:
		death()
	else:
		snd_hit.play()
