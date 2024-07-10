extends Node

class_name State

var character : CharacterBody3D
var nextState : State

signal interrupt_state(newState : State)

func state_process(delta):
	pass
	
func state_input(event : InputEvent):
	pass

func on_enter():
	pass

func on_exit():
	pass
