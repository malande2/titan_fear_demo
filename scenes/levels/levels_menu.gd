extends ColorRect

@onready var animation_player = $AnimationPlayer

func _ready():
	animation_player.play("transition")

func transition_to(next_scene: String):
	animation_player.play_backwards("transition")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(next_scene)

func _on_test_level_pressed():
	transition_to("res://scenes/levels/test_level.tscn")


func _on_boss_level_pressed():
	transition_to("res://scenes/levels/robot_bosses_room.tscn")


func _on_exit_button_pressed():
	get_tree().quit()
