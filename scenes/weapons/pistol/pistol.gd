extends Gun

func _process(delta):
	if reload_timer.is_stopped() && Input.is_action_just_pressed("fire"):
		var bullet: Projectile = projectile.instantiate()
		bullet.position = gunpoint.global_position
		bullet.direction = Vector2.RIGHT.rotated(gunpoint.global_rotation)
		get_tree().current_scene.add_child(bullet)
		reload_timer.start()
