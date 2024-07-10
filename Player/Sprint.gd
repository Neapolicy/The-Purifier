extends State

@export var jump : State
@export var walk : State

var stamina_bar = Hud.get_child(0)

func on_enter():
	character.current_speed = character.SPRINT_VELOCITY
	
func state_input(event : InputEvent):
	var direction = character.direction
	_check_sprinting(get_physics_process_delta_time(), character.direction)
	if event.is_action_released("sprint") || character.exhausted:
		nextState = walk
		print("current state " + nextState.name)

func _check_sprinting(time : float, direction : Vector3):
	if (!character.exhausted && !character.velocity.is_zero_approx()):
		if (stamina_bar.current_stamina > 0):
			stamina_bar.sprinting = true #prevents stamina regen mid sprint
			stamina_bar.consume_stamina(40 * time)
		else:
			character.exhausted = true #prevents player from being able to hold down shift forever
	
func on_exit():
	character.current_speed = character.SPEED
	stamina_bar.sprinting = false
