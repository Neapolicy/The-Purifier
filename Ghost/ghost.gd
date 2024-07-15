extends CharacterBody3D

const SPEED = 10.0
const ACCEL = 2.0

@onready var target = get_tree().get_first_node_in_group("player")
@onready var navi : NavigationAgent3D = $NavigationAgent3D

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	var direction = Vector3()
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	# Calculate the direction towards the next position
	direction = (navi.get_next_path_position() - global_position).normalized()

	velocity = velocity.lerp(direction * SPEED, ACCEL * delta)
	print(velocity)
	move_and_slide()


func _on_timer_timeout():
	navi.target_position = target.global_position
