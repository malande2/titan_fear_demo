extends State
class_name SimpleEnemyAttack

@export var enemy: SimpleEnemy
var player: Player

func enter():
	player = get_tree().get_first_node_in_group("Player") as Player
	
func exit():
	pass

func update(delta: float):
	if enemy.health_component.health <= 0:
		Transitioned.emit(self, "death")
		return
	if player.health_component.health <= 0:
		Transitioned.emit(self, "idle")
		return
	if enemy.position.distance_squared_to(player.position) > enemy.agent.target_desired_distance * enemy.agent.target_desired_distance:
		Transitioned.emit(self, "follow") # do not stop attacking on purpose
	if enemy.melee_weapon.is_attack_possible():
		enemy.melee_weapon.attack()
	enemy.look_at(player.position)
