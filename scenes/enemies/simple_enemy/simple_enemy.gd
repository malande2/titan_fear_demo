extends CharacterBody2D
class_name SimpleEnemy

@onready var agent: NavigationAgent2D = $NavigationAgent2D

func _on_health_component_health_depleated():
	queue_free()
