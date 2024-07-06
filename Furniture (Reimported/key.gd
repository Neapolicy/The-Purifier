extends Node3D

@onready var id = $"../..".key_id

var toggle = false
var interactable = true

# Called when the node enters the scene tree for the first time.
func interact(player):
	player.raycast.pick_up_key(self)
	get_parent().get_parent().visible = false
	print(id)
