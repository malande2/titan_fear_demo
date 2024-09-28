extends Node2D
class_name MeleeWeapon

@export var attack_timer: Timer
@export var reload_timer: Timer

@export var min_damage: int
@export var max_damage: int

func _ready():
	assert(min_damage <= max_damage, "min_damage must be less or equal than max_damage")
	attack_timer.one_shot = true
	attack_timer.timeout.connect(_process_finishing)
	reload_timer.one_shot = true

func _process(delta):
	if attack_timer.is_stopped() && reload_timer.is_stopped() && Input.is_action_just_pressed("melee"):
		attack_timer.start()
		start_attack()

func _process_finishing():
	reload_timer.start()
	finish_attack()

func start_attack():
	pass

func finish_attack():
	pass
