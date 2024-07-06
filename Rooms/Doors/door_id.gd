extends Node3D

@export var door_id : String
@export var lock_color : Color
@onready var lock = $Hinge/lock

func _ready():
	lock.set_color(lock_color)
