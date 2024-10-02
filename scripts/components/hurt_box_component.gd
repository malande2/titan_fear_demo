extends Area2D
class_name HurtBoxComponent

signal received_damage(damage: int)

@export var health: HealthComponent

func _ready():
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D):
	if area is HitBoxComponent:
		var damage = area.apply_damage()
		health.damage(damage)
		received_damage.emit(damage)

func set_enabled(enabled: bool):
	for child in get_children().filter(func (c): return c is CollisionShape2D):
		(child as CollisionShape2D).set_deferred("disabled", !enabled)
