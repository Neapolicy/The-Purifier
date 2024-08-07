extends RayCast3D

var held_key
var ray_cast_y

@onready var player = $"../../.."
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	ray_cast_y = abs(rad_to_deg(player.camera.rotation.x)) / 100 
	target_position = Vector3(0, -1 - ray_cast_y, 0)
	if (is_colliding() && get_collider() != null):
		var hitObj = get_collider()
		if (Input.is_action_just_pressed("interact")):
			if hitObj.has_method("interact"): 
				hitObj.interact(player)
				
func pick_up_key(key):
	if held_key == null:
		held_key = key
		held_key.set_owner(self)
	else: #player already has a key
		drop_key(key)

func drop_key(key):
	if held_key != null:
		held_key.get_parent().get_parent().visible = true #resets key position of previous key
		held_key.set_owner(null)
		held_key = null
		pick_up_key(key)
