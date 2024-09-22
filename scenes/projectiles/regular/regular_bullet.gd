extends RigidBody2D
class_name RegularBullet

@export var direction: Vector2 = Vector2.ONE
@export var velocity: float = 400.0

func _ready():
	rotate(direction.angle() + PI * 0.5)
	apply_central_impulse(direction * velocity)

func _on_hit_box_component_damage_done(damage):
	queue_free()

func _on_body_entered(body):
	queue_free()
