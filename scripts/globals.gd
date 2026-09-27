extends Node

var can_interact_with_root = false

var root_status = false
var can_get_root = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	can_interact_with_root = !root_status and can_interact_with_root
	

var investigate_text = {
	"0text": "VE: That's not old age. That's not weather either.", 
	"0time": 3,
	"1text": "VE: I need to tell someone. Even if they don't listen.", 
	"1time": 3
}

var leave_text = {
	"0text": "VE: It's an old tree. Old things crack. That's not my burden today.", 
	"0time": 3, 
	"1text": "VE: I told myself it wasn't my burden. I was wrong. By the time I looked again, there was nothing left to check.", 
	"1time": 3
}

var init_text = {
	"0text": "VE: I was small when they planted this tree. I have watched it grow for longer than the gods have kept count.", 
	"0time": 4, 
	"1text": "URD: The thread frays, little one.", 
	"1time": 3, 
	"2text": "VE: It has frayed before. It always mends.", 
	"2time": 3, 
	"3text": "SKULD: Not this time.", 
	"3time": 3,
	"4text": "VE: ...That wasn't here last season.", 
	"4time": 3, 
	"4func": "can_get_root", 
	"5text": "Objective: Search for the black root"
}
