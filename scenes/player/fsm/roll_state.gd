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
	player.hurt_box_component.set_enabled(false)
	player.gun.set_enabled(false)
	player.melee_weapon.set_enabled(false)

func exit():
	player.velocity = Vector2.ZERO
	player.hurt_box_component.set_enabled(true)
	player.gun.set_enabled(true)
	player.melee_weapon.set_enabled(true)

func physics_update(delta: float):
	player.move_and_slide()
	if player.position.distance_to(start_position) > DISTANCE or player.get_slide_collision_count() > 0:
		Transitioned.emit(self, "controlled")
