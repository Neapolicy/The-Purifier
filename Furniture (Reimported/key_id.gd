extends Node3D

@export var key_id : String
@export var key_color : Color

var meshes : Array = []

func _ready():
	print("lololo")
	for i in get_children():
		if i is MeshInstance3D:
			meshes.append(i)
	set_color()

func set_color():
	for i in meshes:
		var material = i.get_active_material(0).duplicate()
		i.set_surface_override_material(0, material)
		material.albedo_color = key_color
		print(material.albedo_color)
