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
