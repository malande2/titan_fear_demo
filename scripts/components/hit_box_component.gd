extends Area2D
class_name HitBoxComponent

signal damage_done(damage: int)

@export var damage: int
@export var one_time_applicable: bool = true

var is_active: bool = true

func apply_damage() -> int:
	if is_active:
		if one_time_applicable:
			is_active = false
		damage_done.emit(damage)
		return damage
	return 0

func set_enabled(enabled: bool):
	for child in get_children().filter(func (c): return c is CollisionShape2D):
		(child as CollisionShape2D).set_deferred("disabled", !enabled)
