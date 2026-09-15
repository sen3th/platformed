extends CharacterBody2D

var coins: int = 0

const SPEED = 300.0
const JUMP_VELOCITY = -600.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if global_position.y > 500:
		restart_game()
		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


	move_and_slide()
	
func _process(delta):
	if Input.is_action_just_pressed("restart"):
		restart_game()

func restart_game():
	get_tree().reload_current_scene()
	
@onready var coin_label: Label = $HUD/CoinLabel if has_node("HUD/CoinLabel") else $"../hud/CoinLabel"

func add_coins(amount: int) -> void:
	coins += amount
	if coin_label:
		coin_label.text = "Coins: " + str(coins)
