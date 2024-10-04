extends Node2D
class_name MeleeWeapon

@export var hit_box_component: HitBoxComponent

@export var attack_timer: Timer
@export var reload_timer: Timer

@export var min_damage: int
@export var max_damage: int

signal ready_to_attack

var enabled: bool = true

func _ready():
	assert(min_damage <= max_damage, "min_damage must be less or equal than max_damage")
	if attack_timer != null:
		attack_timer.timeout.connect(_process_finishing)
	if reload_timer != null:
		reload_timer.timeout.connect(_on_reload_timeout)

func is_attack_possible() -> bool:
	return enabled and attack_timer.is_stopped() and reload_timer.is_stopped()

func attack():
	if is_attack_possible():
		attack_timer.start()
		_start_attack()

func _process_finishing():
	reload_timer.start()
	_finish_attack()

func _start_attack():
	pass

func _finish_attack():
	pass

func _on_reload_timeout():
	ready_to_attack.emit()

func set_enabled(enabled: bool):
	self.enabled = enabled
	if enabled:
		if attack_timer.time_left > 0.0:
			attack_timer.stop()
			attack_timer.timeout.emit()
		_enable()
	else:
		_disable()

func _enable():
	pass
	
func _disable():
	pass
