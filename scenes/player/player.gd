extends CharacterBody2D
class_name Player

@onready var gun = %Gun
@onready var machete = $Machete

const PUSH_FORCE = 80.0

func _physics_process(delta):
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is RigidBody2D:
			var dir = (collider.global_position - global_position).normalized()
			collision.get_collider().apply_central_impulse(dir * PUSH_FORCE)

func set_gun_state(enabled: bool):
	if gun != null:
		gun.set_process(enabled)
		gun.set_physics_process(enabled)
