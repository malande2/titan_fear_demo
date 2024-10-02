extends State
class_name SimpleEnemyDeath

@export var enemy: SimpleEnemy

func enter():
	enemy.hurt_box_component.set_enabled(false)
