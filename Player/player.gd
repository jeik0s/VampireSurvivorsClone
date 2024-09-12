extends CharacterBody2D

var movement_speed = 40.0
var hp = 80;


#AttackNodes
@onready var icespear_timer = %IceSpearTimer
@onready var icespear_attack_timer = %IceSpearAttackTimer
@onready var icespear = preload("res://Player/Attack/ice_spear.tscn")

#IceSpear
var icespear_ammo = 0
var icespear_baseammo = 1
var icespear_attackspeed = 1.5
var icespear_level = 1;

#enemies
var enemy_close = []

@onready var sprite = $Sprite2D
@onready var walk_timer = get_node("%walkTimer")

func _ready():
	attack()

func _physics_process(delta):
	movment()
	
func movment():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov,y_mov)
	
	if x_mov > 0:
		sprite.flip_h = true;
	elif x_mov < 0:
		sprite.flip_h = false;
	
	if mov != Vector2.ZERO: 
		if walk_timer.is_stopped():
			if sprite.frame >= sprite.hframes - 1:
				sprite.frame = 0;
			else:
				sprite.frame = 1;
			walk_timer.start()
	
	velocity = mov.normalized() * movement_speed
	move_and_slide()

func attack():
	if icespear_level > 0:
		icespear_timer.wait_time = icespear_attackspeed;
		if icespear_timer.is_stopped():
			icespear_timer.start()


func _on_hurt_box_hurt(damage, _angle, _knockback_amount):
	hp -= damage
	print(hp)


func _on_ice_spear_timer_timeout():
	icespear_ammo += icespear_baseammo
	icespear_attack_timer.start()


func _on_ice_spear_attack_timer_timeout():
	if icespear_ammo > 0:
		var icespear_attack = icespear.instantiate()
		icespear_attack.position = position
		icespear_attack.target = get_random_target()
		icespear_level = icespear_level
		add_child(icespear_attack)
		icespear_ammo -= 1
		if icespear_ammo > 0:
			icespear_attack_timer.start()
		else:
			icespear_attack_timer.stop()
		
		
func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP


func _on_enemy_detection_area_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)


func _on_enemy_detection_area_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)
