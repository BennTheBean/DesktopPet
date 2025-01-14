extends CharacterBody2D

const SPEED = 20.0
var direction = 1
var can_move = true  # Variable to toggle movement

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite = $AnimatedSprite2D
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var popup_menu = get_parent().get_node("PopupMenu")  # Reference the popup menu

func _ready():
	# Connect to the popup menu's signal
	popup_menu.connect("toggle_movement", Callable(self, "_on_toggle_movement"))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Only process movement if can_move is true
	if can_move:
		# Get direction
		if ray_cast_right.is_colliding():
			direction = -1
		if ray_cast_left.is_colliding():
			direction = 1
		
		# Flip the sprite
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
			
		# Play animations
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("walking")
		
		# Apply movement
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
	else:
		# If not moving, play idle animation and stop movement
		animated_sprite.play("idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
# Signal handler for movement toggle
func _on_toggle_movement():
	can_move = !can_move  # Toggle the movement state
