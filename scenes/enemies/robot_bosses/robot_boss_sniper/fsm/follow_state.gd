extends State
class_name RobotBossSniperFollow

@export var robot_sniper: RobotBossSniper
@export var shot_distance: float
@export var speed: float = 40.0
@export var forced_transition_timer: Timer
@export var heat_wave: HeatWave

var player: Player

var _velocity: Vector2 = Vector2.ZERO
var _just_awaken: bool = true

func enter():
	player = get_tree().get_first_node_in_group("Player") as Player
	robot_sniper.agent.velocity_computed.connect(_on_velocity_computed)
	robot_sniper.agent.target_reached.connect(_to_attack)
	robot_sniper.agent.navigation_finished.connect(_to_attack)
	if _just_awaken:
		var dist = robot_sniper.global_position.distance_to(player.global_position)
		var target_position = (player.global_position - robot_sniper.global_position).normalized() * (dist - shot_distance)
		target_position += robot_sniper.global_position
		robot_sniper.agent.target_position = target_position
		_just_awaken = false
	else:
		var rid = (get_tree().current_scene.get_node("%CircleNavigationRegion") as NavigationRegion2D).get_rid()
		robot_sniper.agent.target_position = NavigationServer2D.region_get_random_point(rid, 1, true)
	robot_sniper.rifle.rotation = 0.0
	if forced_transition_timer != null:
		forced_transition_timer.timeout.connect(_to_attack)
		forced_transition_timer.start()

func exit():
	robot_sniper.agent.velocity_computed.disconnect(_on_velocity_computed)
	robot_sniper.agent.target_reached.disconnect(_to_attack)
	robot_sniper.agent.navigation_finished.disconnect(_to_attack)
	robot_sniper.agent.velocity = Vector2.ZERO
	_velocity = Vector2.ZERO
	if forced_transition_timer != null:
		forced_transition_timer.timeout.disconnect(_to_attack)

func update(delta: float):
	if robot_sniper.health_component.health <= 0:
		Transitioned.emit(self, "death")
		return
	if player.health_component.health <= 0:
		Transitioned.emit(self, "idle")
		return
	if not robot_sniper.agent.is_navigation_finished():
		var current_location = robot_sniper.global_position
		var next_location = robot_sniper.agent.get_next_path_position()
		var new_velocity = current_location.direction_to(next_location) * speed
		var steering = (new_velocity - _velocity) * delta * 4.0
		_velocity += steering
		robot_sniper.agent.velocity = _velocity

func _on_velocity_computed(safe_velocity: Vector2):
	robot_sniper.velocity = safe_velocity
	robot_sniper.move_and_slide()
	robot_sniper.look_at(robot_sniper.agent.get_next_path_position())

func _to_attack():
	var distance_to_player = robot_sniper.global_position.distance_to(player.global_position)
	if distance_to_player < heat_wave.radius * 0.75:
		Transitioned.emit(self, "heat_attack")
	else:
		Transitioned.emit(self, "attack")
