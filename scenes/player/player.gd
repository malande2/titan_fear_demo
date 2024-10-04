extends CharacterBody2D
class_name Player

@export var gun: Gun
@export var melee_weapon: MeleeWeapon

@onready var hurt_box_component: HurtBoxComponent = $HurtBoxComponent
@onready var hurt_animation: AnimationPlayer = $HurtAnimation
@onready var health_component: HealthComponent = $HealthComponent

const PUSH_FORCE = 80.0

func _ready() -> void:
	gun.projectile_layer = Utils.PhysicsLayer.PLAYER_PORJECTILE
	gun.projectile_mask = Utils.PhysicsLayer.ENEMY
	melee_weapon.hit_box_component.collision_layer = Utils.PhysicsLayer.PLAYER_PORJECTILE
	melee_weapon.hit_box_component.collision_mask = Utils.PhysicsLayer.ENEMY

func _physics_process(delta):
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is RigidBody2D:
			var dir = (collider.global_position - global_position).normalized()
			collision.get_collider().apply_central_impulse(dir * PUSH_FORCE)


func _on_hurt_box_component_received_damage(damage: int) -> void:
	hurt_animation.play("hurt")
