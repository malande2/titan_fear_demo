extends CharacterBody2D
class_name SimpleEnemy

@onready var agent: NavigationAgent2D = $NavigationAgent2D
@onready var animation_player = $AnimationPlayer
@onready var hurt_box_component = %HurtBoxComponent
@onready var finite_state_machine = $fsm
@onready var health_component: HealthComponent = $HealthComponent

func _on_health_component_health_depleated():
	animation_player.play("hurt")
	animation_player.animation_finished.connect(_free_after_death)

func _on_hurt_box_component_received_damage(damage):
	animation_player.play("hurt")

func _free_after_death(action_name: String):
	queue_free()
