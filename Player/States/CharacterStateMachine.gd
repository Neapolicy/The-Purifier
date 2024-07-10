extends Node


class_name CharStateMachine
# Called when the node enters the scene tree for the first time.
@export var character : CharacterBody3D
@export var currentState : State # is a

var states : Array[State]

func _ready():
	for child in get_children():
		if child is State:
			states.append(child)
			child.character = character #not changing the states, you're changing the child in the states
			
			child.connect("interrupt_state", on_state_interrupt_state)
		else:
			push_warning(child.name + " is not a state")

func _physics_process(delta):
	if (currentState.nextState != null):
		switch_states(currentState.nextState)
		
	currentState.state_process(delta)

func checkStunned():
	return currentState.canMove #remember to change this later
	
func switch_states(new_state : State):
	if (currentState != null):
		currentState.on_exit()
		currentState.nextState = null #clear ouyt the net state
	
	currentState = new_state
	
	currentState.on_enter()

func _input(event : InputEvent):
	currentState.state_input(event)

func on_state_interrupt_state(newState : State):
	switch_states(newState)
