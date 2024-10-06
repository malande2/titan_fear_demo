extends State
class_name RobotBossSniperAttack

@export var robot_sniper: RobotBossSniper

var player: Player

var is_charging: bool = false

func enter():
	player = get_tree().get_first_node_in_group("Player") as Player
	is_charging = false
	robot_sniper.rifle.fired.connect(_on_fired)

func exit():
	robot_sniper.rifle.fired.disconnect(_on_fired)

func update(delta: float):
	if robot_sniper.health_component.health <= 0:
		robot_sniper.rifle.interrupt_charging()
		Transitioned.emit(self, "death")
		return
	if player.health_component.health <= 0:
		Transitioned.emit(self, "idle")
		return
	robot_sniper.look_at(player.global_position)
	robot_sniper.rifle.look_at(player.global_position)
	robot_sniper.rifle.set_ray_position(player.global_position)
	if not is_charging and robot_sniper.rifle.is_attack_possible():
		robot_sniper.rifle.run_charging()
		is_charging = true

func _on_fired():
	Transitioned.emit(self, "follow")
