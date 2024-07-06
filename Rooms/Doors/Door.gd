extends Node3D

var toggle = false
var interactable = true
@export var anim_player : AnimationPlayer
# Called when the node enters the scene tree for the first time.
func interact(player):
	if (interactable):
		interactable = false #prevents player from spam opening while door is playing the anim
		toggle = !toggle
		if (toggle == true):
			anim_player.play("Close")
		if (toggle == false):
			anim_player.play("Open")
		await get_tree().create_timer(1.0, false).timeout #false ensures anim only plays when game is running	
		interactable = true
