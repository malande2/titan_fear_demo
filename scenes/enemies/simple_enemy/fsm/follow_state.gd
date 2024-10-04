extends State
class_name SimpleEnemyFollow

@export var enemy: SimpleEnemy
var player: Player

const SPEED = 60.0

func enter():
	player = get_tree().get_first_node_in_group("Player") as Player
	enemy.agent.velocity_computed.connect(_on_velocity_computed)
	enemy.agent.target_reached.connect(_to_attack)
	enemy.agent.target_position = player.position

func exit():
	enemy.agent.velocity_computed.disconnect(_on_velocity_computed)
	enemy.agent.target_reached.disconnect(_to_attack)
	_change_velocity(Vector2.ZERO)

func update(delta: float):
	if enemy.health_component.health <= 0:
		Transitioned.emit(self, "death")
		return
	if player.health_component.health <= 0:
		Transitioned.emit(self, "idle")
		return
	if enemy.agent.target_position.distance_squared_to(player.position) > 1.0:
		enemy.agent.target_position = player.position
	if not enemy.agent.is_navigation_finished():
		var current_location = enemy.position
		var next_location = enemy.agent.get_next_path_position()
		var new_velocity = current_location.direction_to(next_location) * SPEED
		_change_velocity(new_velocity)
		enemy.move_and_slide()
	
	enemy.look_at(player.position)

func _to_attack():
	Transitioned.emit(self, "attack")

func _change_velocity(new_velocity: Vector2):
	if enemy.agent.avoidance_enabled:
		enemy.agent.velocity = new_velocity
	else:
		enemy.velocity = new_velocity

func _on_velocity_computed(safe_velocity: Vector2):
	enemy.velocity = safe_velocity
