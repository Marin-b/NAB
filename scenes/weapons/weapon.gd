extends Node2D
class_name Weapon

var attack_cooldown = 0;
var rng = RandomNumberGenerator.new()
	
@onready var wielder : Entity = get_parent()

func _ready():
	pass

func set_rotation(angle : float):
	$Pivot.set_global_rotation(angle)
	
func attack():
	if attack_cooldown < 0:
		attack_cooldown = 1 * (1 / wielder.attack_speed)
		play_attack_animation()

func _physics_process(delta):
	set_rotation(wielder.aiming_at)
	attack_cooldown -= delta

# Implement in child class
func play_attack_animation():
	pass

func damage():
	var damage = wielder.m_damage
	if is_crit_attack():
		damage *= 2
	return damage

func is_crit_attack() -> bool:
	rng.randomize()
	return rng.randi_range(0, 100) < wielder.crit_chance
		
	
