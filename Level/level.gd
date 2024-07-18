extends Node3D

@onready var pause_menu = $"CanvasLayer/Pause Menu"
var paused : bool = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("pause")):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		pause()

func pause(): #pause menu
	if (paused):
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
		
	paused = !paused
