extends MeleeWeapon

@onready var hit_box_component = %HitBoxComponent
@onready var blow = %Blow

var hit_box_parent: Node

func _ready():
	super._ready()
	visible = false
	hit_box_parent = hit_box_component.get_parent()
	hit_box_parent.remove_child(hit_box_component)
	blow.speed_scale = 1.0 / attack_timer.wait_time

func start_attack():
	visible = true
	hit_box_parent.add_child(hit_box_component)
	blow.play("blow")

func finish_attack():
	visible = false
	blow.stop()
	hit_box_parent.remove_child(hit_box_component)
