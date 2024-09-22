extends State
class_name RollState

@export var player: Player

var direction: Vector2 = Vector2.ONE
var target_position: Vector2

const SPEED = 600
const DISTANCE = 40

func enter():
	direction = player.position.direction_to(player.get_global_mouse_position())
	target_position = player.position + player.position.direction_to(player.get_global_mouse_position()) * DISTANCE
	player.velocity = direction * SPEED
	# disable a hurt box component

func exit():
	player.velocity = Vector2.ZERO

func physics_update(delta: float):
	player.move_and_slide()
	if player.position.distance_to(target_position) < 1.0 or player.get_slide_collision_count() > 0:
		Transitioned.emit(self, "controlled")
		
