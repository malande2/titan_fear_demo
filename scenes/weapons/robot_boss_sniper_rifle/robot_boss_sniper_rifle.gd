extends Gun
class_name RobotBossSniperRifle

signal fired
signal reloaded

@onready var missile_trace: Line2D = $MissileTrace
@onready var charging_timer = $ChargingTimer
@onready var shot_animation = $ShotAnimation

func is_attack_possible():
	return super.is_attack_possible() and charging_timer.is_stopped()

func _on_reload_timer_timeout():
	reloaded.emit()

func set_ray_position(global_position_to_convert: Vector2):
	missile_trace.points[1] = missile_trace.to_local(global_position_to_convert)

func run_charging():
	if reload_timer.is_stopped() and charging_timer.is_stopped():
		shot_animation.speed_scale = 1.0 / charging_timer.wait_time
		shot_animation.play("shot")
		charging_timer.start()

func interrupt_charging():
	if not charging_timer.is_stopped():
		charging_timer.stop()
		shot_animation.stop()
		set_ray_position(Vector2.ZERO)

func _on_charging_timer_timeout():
	var bullet: Projectile = projectile.instantiate()
	bullet.hit_box.damage = randi_range(min_damage, max_damage)
	bullet.hit_box.collision_layer = projectile_layer
	bullet.hit_box.collision_mask = projectile_mask
	bullet.position = gunpoint.global_position
	bullet.direction = Vector2.RIGHT.rotated(gunpoint.global_rotation)
	get_tree().current_scene.add_child(bullet)
	
	shot_animation.speed_scale = 1.0
	shot_animation.play("post_shot")
	await shot_animation.animation_finished
	fired.emit()
	set_ray_position(Vector2.ZERO)
	reload_timer.start()
