extends MeleeWeapon

@onready var hit_box_component = $HitBoxComponent
@onready var blow = %Blow

func _ready():
	super._ready()
	visible = false
	remove_child(hit_box_component)

func start_attack():
	visible = true
	add_child(hit_box_component)
	blow.play("blow")

func finish_attack():
	visible = false
	blow.stop()
	remove_child(hit_box_component)
