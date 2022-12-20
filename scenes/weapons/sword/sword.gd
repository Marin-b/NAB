extends Weapon
class_name Sword
# Called when the node enters the scene tree for the first time.
@onready var animation_player = $AnimationPlayer

func play_attack_animation():
	animation_player.play('Swing')

func _on_body_hit(body):
	if (body == wielder):
		return

	if (body.has_method('hit')):
		body.hit(self) # Replace with damage instance
