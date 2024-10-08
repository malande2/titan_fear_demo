extends State
class_name RobotBossHeatAttack

@export var robot: CharacterBody2D
@export var heat_wave: HeatWave

func enter():
	var player = get_tree().get_first_node_in_group("Player") as Player
	robot.look_at(player.global_position)
	heat_wave.start_charging()
	heat_wave.heat_finished.connect(_on_heat_finished)
	
func exit():
	heat_wave.heat_finished.disconnect(_on_heat_finished)

func _on_heat_finished():
	Transitioned.emit(self, "follow")
