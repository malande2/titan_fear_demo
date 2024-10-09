extends CharacterBody2D
class_name RobotBossSniper

@export var rifle: RobotBossSniperRifle
@export var trigger_area: Area2D

@onready var agent: NavigationAgent2D = $NavigationAgent2D
@onready var health_component = $HealthComponent
@onready var hurt_animation = $HurtAnimation
@onready var idle = $fsm/idle
@onready var heat_wave = $HeatWave

func _ready():
	rifle.projectile_layer = Utils.PhysicsLayer.ENEMY_PROJECTILE
	rifle.projectile_mask = Utils.PhysicsLayer.PLAYER
	idle.trigger_area = trigger_area

func _on_hurt_box_component_received_damage(damage):
	hurt_animation.play("hurt")

func _on_health_component_health_depleated():
	hurt_animation.play("hurt")
	hurt_animation.animation_finished.connect(_free_after_death)

func _free_after_death(action_name: String):
	queue_free()
