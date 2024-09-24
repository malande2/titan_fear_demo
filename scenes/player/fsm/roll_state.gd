extends State
class_name RollState

@export var player: Player

var direction: Vector2 = Vector2.ONE
var start_position: Vector2

const SPEED = 400
const DISTANCE = 40

func enter():
	start_position = player.position
	if player.velocity.is_zero_approx():
		direction = player.position.direction_to(player.get_global_mouse_position())
	else:
		direction = player.velocity.normalized()
	player.velocity = direction * SPEED
	# disable a hurt box component

func exit():
	player.velocity = Vector2.ZERO

func physics_update(delta: float):
	player.move_and_slide()
	if player.position.distance_to(start_position) > DISTANCE or player.get_slide_collision_count() > 0:
		Transitioned.emit(self, "controlled")
