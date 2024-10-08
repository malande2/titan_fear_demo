extends Node

@onready var trigger_area = $TriggerArea
@onready var navigation_region_2d: NavigationRegion2D = $NavigationRegion2D

func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/levels/levels_menu.tscn")

func _on_area_2d_area_entered(area):
	trigger_area.call_deferred("queue_free")
