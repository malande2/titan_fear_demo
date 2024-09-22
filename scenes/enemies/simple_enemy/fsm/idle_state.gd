extends State
class_name SimpleEnemyIdle

@export var enemy: CharacterBody2D
var player: Player

func enter():
	player = get_tree().get_first_node_in_group("Player") as Player

func update(delta: float):
	var dist = player.position - enemy.position
	if dist.length_squared() < 150 * 150:
		Transitioned.emit(self, "follow")
