extends CharacterBody2D
class_name Player

@onready var gun_position: Marker2D = $GunPosition

const PUSH_FORCE = 80.0

func _physics_process(delta):
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is RigidBody2D:
			var dir = (collider.global_position - global_position).normalized()
			collision.get_collider().apply_central_impulse(dir * PUSH_FORCE)
