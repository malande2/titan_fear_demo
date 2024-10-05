extends State
class_name SimpleEnemyFollow

@export var enemy: SimpleEnemy
var player: Player

const SPEED = 60.0

var _velocity: Vector2 = Vector2.ZERO

func enter():
	player = get_tree().get_first_node_in_group("Player") as Player
	enemy.agent.velocity_computed.connect(_on_velocity_computed)
	enemy.agent.target_reached.connect(_to_attack)
	enemy.agent.target_position = player.global_position

func exit():
	enemy.agent.velocity_computed.disconnect(_on_velocity_computed)
	enemy.agent.target_reached.disconnect(_to_attack)
	enemy.agent.velocity = Vector2.ZERO
	_velocity = Vector2.ZERO

func update(delta: float):
	if enemy.health_component.health <= 0:
		Transitioned.emit(self, "death")
		return
	if player.health_component.health <= 0:
		Transitioned.emit(self, "idle")
		return
	if enemy.agent.target_position.distance_squared_to(player.global_position) > 1.0:
		enemy.agent.target_position = player.global_position
	if not enemy.agent.is_navigation_finished():
		var current_location = enemy.global_position
		var next_location = enemy.agent.get_next_path_position()
		var new_velocity = current_location.direction_to(next_location) * SPEED
		var steering = (new_velocity - _velocity) * delta * 4.0
		_velocity += steering
		enemy.agent.velocity = _velocity

func _to_attack():
	Transitioned.emit(self, "attack")

func _on_velocity_computed(safe_velocity: Vector2):
	enemy.velocity = safe_velocity
	enemy.move_and_slide()
	enemy.rotation = safe_velocity.angle()
