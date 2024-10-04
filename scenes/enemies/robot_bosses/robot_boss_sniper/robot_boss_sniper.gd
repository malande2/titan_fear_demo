extends CharacterBody2D
class_name RobotBossSniper

@export var rifle: RobotBossSniperRifle

func _ready() -> void:
	rifle.projectile_layer = Utils.PhysicsLayer.ENEMY_PROJECTILE
	rifle.projectile_mask = Utils.PhysicsLayer.PLAYER
