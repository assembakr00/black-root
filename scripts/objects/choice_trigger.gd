extends Area2D

signal choice_made(choice: String)

@onready var choice_ui: CanvasLayer = $ChoiceUI
@onready var investigate_button: Button = $ChoiceUI/Panel/Investigate
@onready var leave_button: Button = $ChoiceUI/Panel/Leave

var triggered := false


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	investigate_button.pressed.connect(_on_investigate_pressed)
	leave_button.pressed.connect(_on_leave_pressed)
	choice_ui.visible = false


func _on_body_entered(body: Node2D) -> void:
	if triggered or not body.is_in_group("player"):
		return

	triggered = true
	GameState.input_locked = true
	choice_ui.visible = true
	set_deferred("monitoring", false)


func _on_investigate_pressed() -> void:
	_finish_choice("check")


func _on_leave_pressed() -> void:
	_finish_choice("leave")


func _finish_choice(value: String) -> void:
	GameState.choice = value
	choice_made.emit(value)
	get_tree().change_scene_to_file("res://Ending.tscn")
