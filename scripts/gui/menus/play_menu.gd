extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_level_1_pressed() -> void:
	$ButtonAudio.play()
	get_tree().call_deferred("change_scene_to_file", "res://scenes/areas_in_world/level_1.tscn")


func _on_back_pressed() -> void:
	$ButtonAudio.play()
	get_tree().call_deferred("change_scene_to_file", "res://scenes/gui/menus/main_menu.tscn")


func _on_play_level_2_pressed() -> void: # Level 2 doesn't exist yet
	get_tree().call_deferred("change_scene_to_file", "res://scenes/areas_in_world/level_2.tscn")


func _on_play_level_3_pressed() -> void: # Level 3 doesn't exist yet
	get_tree().call_deferred("change_scene_to_file", "res://scenes/areas_in_world/level_3.tscn")


func _on_play_level_4_pressed() -> void: # Level 4 doesn't exist yet
	get_tree().call_deferred("change_scene_to_file", "res://scenes/areas_in_world/level_4.tscn")
