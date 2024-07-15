extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.9
const SPRINT_VELOCITY = 7.5
const SENSITIVITY = .01
const CROUCH_VELOCITY = 2.5

#bob variables
const BOB_FREQ = 2.0
const BOB_AMP = 0.08
var  t_bob = 0.0
var shape
@onready var neck = $Neck
@onready var camera = $Neck/Camera3D
@onready var raycast = $Neck/Camera3D/RayCast3D
@onready var collision_shape = $CollisionShape3D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var stamina_bar = Hud.get_child(0)
var exhausted : bool
var direction
var current_speed = 5.0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event):
	if (event is InputEventMouseButton):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif (event.is_action_pressed("ui_cancel")):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if (Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED):
		if (event is InputEventMouseMotion):
			neck.rotate_y(-event.relative.x * SENSITIVITY)
			camera.rotate_x(-event.relative.y * SENSITIVITY)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-90), deg_to_rad(90)) #also increase raycast size if player looks down/up
	
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if (stamina_bar.current_stamina == stamina_bar.max_stamina):
		exhausted = false
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() #prevents issues with character going wrong way
	if is_on_floor():
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
		#_check_sprinting(delta, direction)
	else:
		velocity.x = lerp(velocity.x, direction.x * current_speed, delta * 2.0)
		velocity.z = lerp(velocity.z, direction.z * current_speed, delta * 2.0)
	#if (Input.is_action_just_pressed("crouch")):
		#change_collision_shape_size(Vector3(2, 2, 2))
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	move_and_slide()
			
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
