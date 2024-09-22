extends Node
class_name HealthComponent

signal health_changed(diff: int)
signal health_depleated

@export var max_health: int = 10

@onready var health: int = max_health

func damage(attack: int):
	var pure_damage = min(health, attack)
	if pure_damage > 0:
		health -= pure_damage
		if health > 0:
			health_changed.emit(-pure_damage)
		else:
			health_depleated.emit()

func heal(healing: int):
	var pure_healing = min(max_health - health, healing)
	if pure_healing > 0:
		health += pure_healing
		health_changed.emit(pure_healing)
