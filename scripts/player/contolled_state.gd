extends State
class_name ControlledState

@export var player: Player

const SPEED = 100.0
const PUSH_FORCE = 80.0

const bullet_path = preload("res://scenes/projectiles/regular_bullet.tscn")

func update(delta: float):
	if Input.is_action_just_pressed("fire"):
		var bullet = bullet_path.instantiate() as RegularBullet
		var pos: Vector2 = player.gun_position.global_position
		bullet.position = pos
		bullet.direction = (player.get_global_mouse_position() - pos).normalized()
		player.get_parent().add_child(bullet)

func physics_update(delta: float):
	var mouse_position = player.get_global_mouse_position()
	player.look_at(mouse_position)
	
	var direction = Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * SPEED
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, SPEED)
		
	direction = Input.get_axis("up", "down")
	if direction:
		player.velocity.y = direction * SPEED
	else:
		player.velocity.y = move_toward(player.velocity.y, 0, SPEED)

	player.move_and_slide()
	for i in player.get_slide_collision_count():
		var collision = player.get_slide_collision(i)
		var collider = collision.get_collider()
		if collider is RigidBody2D:
			var dir = (collider.global_position - player.global_position).normalized()
			collision.get_collider().apply_central_impulse(dir * PUSH_FORCE)
