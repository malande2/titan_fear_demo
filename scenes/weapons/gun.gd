extends Node2D
class_name Gun

@export var gunpoint: Marker2D
@export var projectile: Resource
@export var reload_timer: Timer
@export var projectile_layer: int
@export var projectile_mask: int

@export var min_damage: int
@export var max_damage: int

var enabled: bool = true

func is_attack_possible() -> bool:
	return enabled and reload_timer.is_stopped()

func set_enabled(enabled: bool):
	self.enabled = enabled
	if enabled:
		_enable()
	else:
		_disable()

func _enable():
	pass
	
func _disable():
	pass
