extends Sprite2D

@onready var animation_player = $AnimationPlayer


func _ready():
	animation_player.play("animation_explode")


func _on_animation_player_animation_finished(anim_name):
	queue_free()
