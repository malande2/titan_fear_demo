extends RigidBody2D
class_name Projectile

@export var direction: Vector2 = Vector2.ONE
@export var velocity: float = 0.0
@export var hit_box: HitBoxComponent
@export var screen_notifier: VisibleOnScreenNotifier2D

func _ready():
	body_entered.connect(_on_body_entered)
	hit_box.damage_done.connect(_on_hit_box_component_damage_done)
	screen_notifier.screen_exited.connect(_on_visible_on_screen_notifier_2d_screen_exited)
	
	rotate(direction.angle() + PI * 0.5)
	apply_central_impulse(direction * velocity)

func _on_hit_box_component_damage_done(damage):
	queue_free()

func _on_body_entered(body):
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
