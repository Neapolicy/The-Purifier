extends State

@export var jump : State
@export var walk : State
@export var char_hurt_box : CollisionShape3D
# Called when the node enters the scene tree for the first time.

func on_enter():
	char_hurt_box.shape.extents.y /= 2.5
	character.current_speed = character.CROUCH_VELOCITY
	print("crouch state")

func on_exit():
	char_hurt_box.shape.extents.y *= 2.5
	character.current_speed = character.SPEED
	
func state_input(event : InputEvent):
	if (event.is_action_pressed("crouch")):
		nextState = walk
	elif (event.is_action_pressed("ui_accept")):
		nextState = jump
