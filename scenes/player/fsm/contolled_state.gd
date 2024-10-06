extends State
class_name ControlledState

@export var player: Player

const SPEED = 80.0

func enter():
	pass

func physics_update(delta: float):
	var mouse_position = player.get_global_mouse_position()
	player.look_at(mouse_position)
	
	if Input.is_action_just_pressed("roll"):
		Transitioned.emit(self, "roll")
		return
	
	if Input.is_action_just_pressed("melee") and player.melee_weapon.is_attack_possible():
		player.melee_weapon.attack()
	
	var x = Input.get_axis("left", "right")
	var y = Input.get_axis("up", "down")
	var direction = Vector2(x, y).normalized()
	
	player.velocity = direction * SPEED
	player.move_and_slide()
