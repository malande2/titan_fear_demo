extends Node2D
class_name HeatWave

signal heat_finished

@export var radius: float
@export var charging_time: float
@export var heat_time: float
@export var damage: float

@onready var hit_box_component = $HitBoxComponent
@onready var collision_shape_2d: CollisionShape2D = $HitBoxComponent/CollisionShape2D
@onready var charging_timer = $ChargingTimer
@onready var heat_wave_timer = $HeatWaveTimer


var _is_active: bool = false
var _velocity: float
var _charging_radius: float = 0.0
var _heat_wave_alpha: float = 0.2

func _ready():
	hit_box_component.set_enabled(false)
	(collision_shape_2d.shape as CircleShape2D).radius = radius
	
	_velocity = radius / charging_time
	
	charging_timer.wait_time = charging_time
	charging_timer.timeout.connect(_on_charging_finished)
	
	heat_wave_timer.wait_time = heat_time
	heat_wave_timer.timeout.connect(_on_heat_finished)

func _process(delta: float):
	if _is_active:
		if not charging_timer.is_stopped():
			_charging_radius += delta * _velocity
		queue_redraw()

func _draw():
	if not charging_timer.is_stopped() or not heat_wave_timer.is_stopped():
		draw_circle(Vector2.ZERO, radius, Color.RED, false, 0.5, true)
		draw_circle(Vector2.ZERO, _charging_radius, Color(Color.RED, _heat_wave_alpha), true)

func is_possible():
	return not _is_active

func start_charging():
	if is_possible():
		_charging_radius = 0
		_heat_wave_alpha = 0.2
		_is_active = true
		charging_timer.start()

func interrupt_charging():
	if _is_active:
		if not charging_timer.is_stopped():
			charging_timer.stop()
		if not heat_wave_timer.is_stopped():
			heat_wave_timer.stop()
		_on_heat_finished()
		

func _on_charging_finished():
	hit_box_component.set_enabled(true)
	heat_wave_timer.start()
	_heat_wave_alpha = 0.6

func _on_heat_finished():
	hit_box_component.set_enabled(false)
	_is_active = false
	_charging_radius = 0
	_heat_wave_alpha = 0.2
	heat_finished.emit()
	
