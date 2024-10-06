extends State
class_name RobotBossHeatAttack

@export var heat_wave: HeatWave

func enter():
	heat_wave.start_charging()
	heat_wave.heat_finished.connect(_on_heat_finished)
	
func exit():
	heat_wave.heat_finished.disconnect(_on_heat_finished)

func _on_heat_finished():
	Transitioned.emit(self, "follow")
