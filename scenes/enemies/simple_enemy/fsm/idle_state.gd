extends State
class_name SimpleEnemyIdle

@export var enemy: SimpleEnemy
var player: Player

@onready var hurt_box: HurtBoxComponent = %HurtBoxComponent

func enter():
	player = get_tree().get_first_node_in_group("Player") as Player
	hurt_box.received_damage.connect(received_damage)

func exit():
	hurt_box.received_damage.disconnect(received_damage)

func update(delta: float):
	if enemy.position.distance_squared_to(player.position) < 150 * 150:
		Transitioned.emit(self, "follow")

func received_damage(damage):
	Transitioned.emit(self, "follow")
