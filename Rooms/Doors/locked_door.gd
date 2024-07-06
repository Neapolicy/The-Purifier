extends "res://Rooms/Doors/Door.gd"

@onready var door_id = $"../..".door_id

var locked = true
var unlocked
# Called when the node enters the scene tree for the first time.
func interact(player):
	if !locked:
		super.interact(player)
	elif player.raycast.held_key != null and player.raycast.held_key.id == door_id:
		locked = false
	else:
		print(door_id + " door is locked") #play locked door sound

