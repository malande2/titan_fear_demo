extends State
class_name SimpleEnemyDeath

@export var enemy: SimpleEnemy

func enter():
	enemy.melee_weapon.set_enabled(false)
	enemy.hurt_box_component.set_enabled(false)
