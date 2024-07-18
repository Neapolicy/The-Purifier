extends Control

@onready var main = $"../.."

func _on_resume_pressed():
	main.pause()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _on_restart_pressed():
	main.pause()
	main.get_tree().reload_current_scene()
	Hud.get_child(0).reset_values()


func _on_quit_pressed():
	get_tree().quit()
