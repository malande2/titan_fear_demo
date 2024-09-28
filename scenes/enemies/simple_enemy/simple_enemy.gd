extends CharacterBody2D
class_name SimpleEnemy

@onready var agent: NavigationAgent2D = $NavigationAgent2D
@onready var animation_player = $AnimationPlayer
@onready var hurt_box_component = %HurtBoxComponent
@onready var finite_state_machine = $FiniteStateMachine

func _on_health_component_health_depleated():
	call_deferred("remove_child", hurt_box_component)
	call_deferred("remove_child", finite_state_machine) # replace with a death state
	animation_player.play("hurt")
	animation_player.animation_finished.connect(_free_after_death)

func _on_hurt_box_component_received_damage(damage):
	animation_player.play("hurt")

func _free_after_death(action_name: String):
	queue_free()
