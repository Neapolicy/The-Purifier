extends State

@export var jump : State
@export var crouch : State
@export var sprint : State
# Dummy state, default state, movement is handled by the player script
func state_input(event : InputEvent):
	if (event.is_action_pressed("sprint") && !character.exhausted):
		nextState = sprint
