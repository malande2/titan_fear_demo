extends Gun
class_name Pistol

func _process(delta):
	if !enabled: return
	if reload_timer.is_stopped() && Input.is_action_just_pressed("fire"):
		var bullet: Projectile = projectile.instantiate()
		bullet.hit_box.collision_layer = projectile_layer
		bullet.hit_box.collision_mask = projectile_mask
		bullet.position = gunpoint.global_position
		bullet.direction = Vector2.RIGHT.rotated(gunpoint.global_rotation)
		get_tree().current_scene.add_child(bullet)
		reload_timer.start()
