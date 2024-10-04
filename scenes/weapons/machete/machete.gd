extends MeleeWeapon

@onready var attack_animation = $Animation

func _ready():
	super._ready()
	hit_box_component.set_enabled(false)
	attack_animation.speed_scale = 1.0 / (attack_timer.wait_time if attack_timer != null else 1.0)

func _start_attack():
	hit_box_component.damage = randi_range(min_damage, max_damage)
	hit_box_component.set_enabled(true)
	attack_animation.play("slash")

func _finish_attack():
	attack_animation.play("RESET")
	hit_box_component.set_enabled(false)
