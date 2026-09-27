extends Node2D

const CHECK_LINES: Array[String] = [
	"That's not old age. That's not weather either.",
	"I need to tell someone. Even if they don't listen."
]
const LEAVE_LINES: Array[String] = [
	"It's an old tree. Old things crack. That's not my burden today.",
	"One season passed. Then another. No one came.",
	"I told myself it wasn't my burden. I was wrong."
]

@onready var line_label: Label = $Dialogue/Line
@onready var ember: Sprite2D = $Ember
@onready var background: Sprite2D = $Background
@onready var end_screen: CanvasLayer = $EndScreen
@onready var restart_button: Button = $EndScreen/Panel/Restart

var lines: Array[String] = []
var line_index := 0
var input_enabled := false


func _ready() -> void:
	restart_button.pressed.connect(_on_restart_pressed)
	end_screen.visible = false

	if GameState.choice == "check":
		lines = CHECK_LINES
		ember.visible = true
	else:
		lines = LEAVE_LINES
		ember.visible = false
		background.modulate = Color(0.35, 0.35, 0.35, 1.0)

	_show_current_line()
	call_deferred("_enable_input")


func _enable_input() -> void:
	input_enabled = true


func _unhandled_input(event: InputEvent) -> void:
	if not input_enabled or end_screen.visible:
		return

	var pressed := false
	if event is InputEventKey:
		pressed = event.pressed and not event.echo
	elif event is InputEventMouseButton:
		pressed = event.pressed

	if pressed:
		_advance_line()


func _advance_line() -> void:
	line_index += 1
	if line_index >= lines.size():
		line_label.visible = false
		end_screen.visible = true
		return

	_show_current_line()


func _show_current_line() -> void:
	line_label.text = lines[line_index]


func _on_restart_pressed() -> void:
	GameState.choice = ""
	GameState.input_locked = false
	get_tree().change_scene_to_file("res://scenes/gui/menus/main_menu.tscn")
