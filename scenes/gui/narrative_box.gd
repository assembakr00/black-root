extends Control

var curr_text = globals.init_text
var curr_step = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Update the text
	if str(globals.root_status) == "investigate":
		if curr_text != globals.investigate_text:
			restart()
		curr_text = globals.investigate_text
	elif str(globals.root_status) == "leave":
		if curr_text != globals.leave_text:
			restart()
		curr_text = globals.leave_text
	
	#print("narrator timer at: ", $NarratorTimer.time_left)
	#print("curr_step is: ", curr_step)
	#print("curr_text is: ", curr_text)
	
	# Show the text
	if curr_text:
		if $NarratorTimer.time_left == 0:
			change_time(curr_text)
			show_text(curr_text)

# Update the text
func show_text(text_dict):
	if str(curr_step) + "text" in text_dict:
		$NarratorText.text = text_dict[str(curr_step) + "text"]
	else:
		return "No text found"

# Restarts the text and tiemr
func restart():
	curr_step = -1
	change_time(curr_text, 1)

# Start the timer
func change_time(text_dict, time = null):
	if str(curr_step) + "time" in text_dict:
		$NarratorTimer.start(text_dict[str(curr_step) + "time"] if !time else time)
	else:
		return "No time set"


func _on_narrator_timer_timeout() -> void:
	curr_step += 1
