extends Node2D

var touched_root = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if touched_root:
		#$Player/NarrativeBox.curr_text = globals.level_1_text
	pass


func _on_blackened_root_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Player touched root")
		touched_root = true
