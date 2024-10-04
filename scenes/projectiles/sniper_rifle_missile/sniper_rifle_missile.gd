extends Projectile
class_name ShiperRifleMissile

func _ready() -> void:
	apply_central_impulse(direction * velocity)
