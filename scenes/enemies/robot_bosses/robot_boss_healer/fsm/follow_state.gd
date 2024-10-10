extends State
class_name RobotBossHealerFollow

@export var robot_healer: RobotBossHealer
@export var path_follow: PathFollow2D
@export var speed: float = 40.0
@export var heat_wave_radius: float
@export var transition_timer: Timer

var player: Player

func enter():
	robot_healer.rotation = 0
	player = get_tree().get_first_node_in_group("Player") as Player
	if transition_timer != null:
		transition_timer.timeout.connect(_to_attack)
		transition_timer.start()
	
func exit():
	if transition_timer != null:
		transition_timer.timeout.disconnect(_to_attack)
		transition_timer.stop()
	
func update(delta: float):
	if robot_healer.health_component.health <= 0:
		Transitioned.emit(self, "death")
		return
	if player.health_component.health <= 0:
		Transitioned.emit(self, "idle")
		return
	path_follow.progress += speed * delta

func _to_attack():
	var distance_to_player = robot_healer.global_position.distance_to(player.global_position)
	if distance_to_player < heat_wave_radius:
		Transitioned.emit(self, "heat_attack")
	else:
		Transitioned.emit(self, "healing")
