extends Node
class_name FiniteStateMachine

@export var initial_state: State

var states: Dictionary = {}
var current_state: State

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transitioned)


func _process(delta):
	if current_state == null:
		current_state = initial_state
		current_state.enter()
	else:
		current_state.update(delta)
		
func _physics_process(delta):
	if current_state != null:
		current_state.physics_update(delta)

func on_child_transitioned(from_state: State, to_state_name: String):
	if from_state != current_state:
		return
		
	var to_state = states.get(to_state_name.to_lower())
	if to_state == null:
		return

	if current_state != null:
		current_state.exit()
	
	current_state = to_state
	current_state.enter()
