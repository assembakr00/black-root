extends Area2D

const DEATH_SCREEN_SECONDS := 1.5

var player_died := false


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if player_died or not body.is_in_group("player"):
		return

	player_died = true
	GameState.input_locked = true
	body.velocity = Vector2.ZERO
	_show_death_screen()
	await get_tree().create_timer(DEATH_SCREEN_SECONDS).timeout
	GameState.input_locked = false
	get_tree().change_scene_to_file("res://scenes/areas_in_world/level_1.tscn")


func _show_death_screen() -> void:
	var screen := CanvasLayer.new()
	screen.name = "DeathScreen"
	add_child(screen)

	var background := ColorRect.new()
	background.color = Color(0.02, 0.01, 0.01, 0.88)
	background.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	screen.add_child(background)

	var message := Label.new()
	message.text = "WHAT???"
	message.add_theme_font_size_override("font_size", 72)
	message.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	message.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	message.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	screen.add_child(message)
