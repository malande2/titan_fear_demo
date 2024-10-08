extends State
class_name RobotBossIdle

@export var hurt_box: HurtBoxComponent # to disable in enter and to enable in exit
@export var trigger_area: Area2D # to start a boss fight if the player touches the trigger

func enter():
	hurt_box.set_enabled(false)
	if trigger_area != null:
		trigger_area.area_entered.connect(trigger)

func exit():
	hurt_box.set_enabled(true)
	if trigger_area != null:
		trigger_area.area_entered.disconnect(trigger)

func received_damage(damage):
	Transitioned.emit(self, "follow")

func trigger(area):
	Transitioned.emit(self, "follow")
