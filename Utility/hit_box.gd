extends Area2D

@export var damage = 1
@onready var disiabled_hitbox_timer = $DisiabledHitboxTimer
@onready var collision = $CollisionShape2D

func tempdisabled():
	collision.call_deferred("set","disabled",true)
	disiabled_hitbox_timer.start()

func _on_disiabled_hitbox_timer_timeout():
	collision.call_deferred("set","disabled",false)
