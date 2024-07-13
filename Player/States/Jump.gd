extends State

@export var sprint : State
@export var walk : State
# Called when the node enters the scene tree for the first time.

func state_process(delta):
	if (character.is_on_floor()):
		nextState = walk

func on_enter():
	print("current state: air")
