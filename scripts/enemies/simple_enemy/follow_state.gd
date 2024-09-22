extends State
class_name SimpleEnemyFollow

@export var enemy: SimpleEnemy
var player: Player

const SPEED = 60.0

func enter():
	player = get_tree().get_first_node_in_group("Player") as Player
	enemy.agent.velocity_computed.connect(_on_velocity_computed)

func exit():
	enemy.agent.velocity_computed.disconnect(_on_velocity_computed)

func update(delta: float):
	enemy.agent.target_position = player.position
	if !enemy.agent.is_navigation_finished():
		var current_location = enemy.position
		var next_location = enemy.agent.get_next_path_position()
		var new_velocity = current_location.direction_to(next_location) * SPEED
		if enemy.agent.avoidance_enabled:
			enemy.agent.velocity = new_velocity
		else:
			enemy.velocity = new_velocity
		enemy.move_and_slide()
	
	enemy.look_at(player.position)

func _on_velocity_computed(safe_velocity: Vector2):
	enemy.velocity = safe_velocity
