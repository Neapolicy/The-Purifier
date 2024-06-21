extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const SPRINT_VELOCITY = 1.5

@onready var neck = $Neck
@onready var camera = $Neck/Camera3D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var stamina_bar = Hud.get_child(0)
var exhausted : bool

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _unhandled_input(event):
	if (event is InputEventMouseButton):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	elif (event.is_action_pressed("ui_cancel")):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if (Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED):
		if (event is InputEventMouseMotion):
			neck.rotate_y(-event.relative.x * .01)
			camera.rotate_x(-event.relative.y * .01)
			camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-30), deg_to_rad(60))
	
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
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized() #prevents issues with character going wrong way
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if (Input.is_action_pressed("sprint") && !exhausted):
			if (stamina_bar.current_stamina > 0):
				stamina_bar.sprinting = true
				stamina_bar.consume_stamina(20 * delta)
				velocity.z *= SPRINT_VELOCITY
				velocity.x *= SPRINT_VELOCITY
			else:
				exhausted = true #prevents player from being able to hold down shift forever
		else:
			stamina_bar.sprinting = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()