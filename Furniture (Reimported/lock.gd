extends Node3D

@onready var mesh = $Cube
@onready var mesh2 = $Cube_001

func set_color(color : Color):
	var material = mesh.get_active_material(0).duplicate()
	var material_two = mesh2.get_active_material(0).duplicate()
	mesh.set_surface_override_material(0, material)
	material.albedo_color = color
