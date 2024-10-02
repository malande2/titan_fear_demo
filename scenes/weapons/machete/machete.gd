extends MeleeWeapon

@onready var hit_box_component = %HitBoxComponent
@onready var blow = %Blow

func _ready():
	super._ready()
	var kek: CollisionShape2D = null
	hit_box_component.set_enabled(false)
	blow.speed_scale = 1.0 / attack_timer.wait_time

func start_attack():
	hit_box_component.set_enabled(true)
	blow.play("blow")

func finish_attack():
	blow.play("RESET")
	hit_box_component.set_enabled(false)
