extends Area2D
class_name RegularBullet

@export var direction: Vector2 = Vector2.ONE
@export var velocity: float = 400.0

func _ready():
	rotate(direction.angle() + PI * 0.5)

func _physics_process(delta):
	position += direction * velocity * delta


func _on_body_entered(body):
	queue_free()
