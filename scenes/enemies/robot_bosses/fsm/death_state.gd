extends State
class_name RobotBossDeath

@export var hurt_box: HurtBoxComponent
@export var melee_weapon: MeleeWeapon
@export var gun: Gun

func enter():
	hurt_box.set_enabled(false)
	if melee_weapon != null:
		melee_weapon.set_enabled(false)
	if gun != null:
		gun.set_enabled(false)
