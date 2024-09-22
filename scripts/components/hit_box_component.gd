extends Area2D
class_name HitBoxComponent

@export var damage: int
@export var one_time_applicable: bool = true

var is_active: bool = true
	
func apply_damage() -> int:
	if is_active:
		if one_time_applicable:
			is_active = false
		return damage
	return 0
