extends Entity

@onready var hit_animation_player = $HitAnimationPlayer

func hit(hit_weapon : Weapon):
	if hit_weapon.global_position.x > position.x:
		hit_animation_player.play('hit_right')
	else:
		hit_animation_player.play('hit_left')
		
	super(hit_weapon)
