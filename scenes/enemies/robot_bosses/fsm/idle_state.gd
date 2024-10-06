extends State
class_name RobotBossIdle

@export var hurt_boxes: Array[HurtBoxComponent] # to start a boss fight if any of the robots gets hurt
@export var trigger_area: Area2D # to start a boss fight if the player touches the trigger

func enter():
	for hurt_box in hurt_boxes:
		hurt_box.received_damage.connect(received_damage)
	if trigger_area != null:
		trigger_area.area_entered.connect(trigger)

func exit():
	for hurt_box in hurt_boxes:
		hurt_box.received_damage.disconnect(received_damage)
	if trigger_area != null:
		trigger_area.area_entered.disconnect(trigger)

func received_damage(damage):
	Transitioned.emit(self, "follow")

func trigger(area):
	Transitioned.emit(self, "follow")
