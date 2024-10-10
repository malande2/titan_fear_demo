extends CharacterBody2D
class_name RobotBossHealer

@export var trigger_area: Area2D
@export var path_follow: PathFollow2D

@onready var idle: RobotBossIdle = $fsm/idle
@onready var follow: RobotBossHealerFollow = $fsm/follow
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurt_animation: AnimationPlayer = $HurtAnimation

func _ready():
	idle.trigger_area = trigger_area
	follow.path_follow = path_follow
	

func _on_hurt_box_component_received_damage(damage: int):
	hurt_animation.play("hurt")

func _on_health_component_health_depleated():
	hurt_animation.play("hurt")
	hurt_animation.animation_finished.connect(_free_after_death)

func _free_after_death(action_name: String):
	queue_free()
