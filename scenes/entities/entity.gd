extends CharacterBody2D
class_name Entity

@onready var weapon = $Weapon

var aiming_at = 0.0
var animation := "Idle"
var is_attacking = false

# Stats
@export var max_health := 100
@export var armor := 10
@export var m_damage := 10
@export var r_damage := 10
@export var move_speed := 400
@export var attack_speed := 1.0
@export var crit_chance := 10

signal dead
signal current_health_updated
signal max_health_updated

var current_health := max_health

func hit(hit_weapon : Weapon):
	set_hit_shader()
	set_health(current_health - hit_weapon.damage())

func set_hit_shader():
	material.set_shader_parameter('flash_modifier', 0.5)
	var timer = Timer.new()
	timer.connect("timeout", remove_hit_shader)
	timer.wait_time = 0.1
	timer.one_shot = true
	add_child(timer)
	timer.start()
	
func remove_hit_shader():
	print('removing hit shader')
	material.set_shader_parameter('flash_modifier', 0.0)

func spawn(spawn_pos : Vector2):
	max_health_updated.emit(max_health)
	set_health(max_health)
	position = spawn_pos

func set_health(new_value):
	if new_value <= 0:
		death()
	current_health = new_value
	current_health_updated.emit(new_value)


func death():
	remove_hit_shader()
	dead.emit(self)

