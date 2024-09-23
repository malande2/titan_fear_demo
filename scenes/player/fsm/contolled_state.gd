extends State
class_name ControlledState

@export var player: Player

@onready var shot_timer = %ShotCooldown

const SPEED = 80.0

const bullet_path = preload("res://scenes/projectiles/regular/regular_bullet.tscn")

func update(delta: float):
	if Input.is_action_just_pressed("fire") and shot_timer.is_stopped():
		var bullet = bullet_path.instantiate() as RegularBullet
		var pos: Vector2 = player.gun_position.global_position
		bullet.position = pos
		bullet.direction = player.gun_position.global_position.direction_to(player.get_global_mouse_position())
		player.get_parent().add_child(bullet)
		shot_timer.start()

func physics_update(delta: float):
	var mouse_position = player.get_global_mouse_position()
	player.look_at(mouse_position)
	
	if Input.is_action_just_pressed("roll"):
		Transitioned.emit(self, "roll")
		return
	
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
