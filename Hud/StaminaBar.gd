extends TextureProgressBar

var max_stamina : int = 100
var current_stamina : float = 100
var stamina_regen_rate: float = 10.0  # Stamina points per second
var sprinting

# Called when the node enters the scene tree for the first time.
func _ready(): #issue is you immedietly regenerate stamina when you hit 0, so I have to add a delay
	update_stamina_bar()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Regenerate stamina over time
	if (current_stamina < max_stamina && !sprinting):
		current_stamina += stamina_regen_rate * delta
		if current_stamina > max_stamina:
			current_stamina = max_stamina
		update_stamina_bar()

func consume_stamina(amount: float):
	# Consume stamina
	current_stamina -= amount
	if current_stamina < 1:
		current_stamina = 0.0
	update_stamina_bar()

func update_stamina_bar():
	# Update the progress bar value
	value = current_stamina

func reset_values():
	current_stamina = 100
	update_stamina_bar()
