extends CharacterBody2D



const SPEED = 100.0
const JUMP_VELOCITY = -400.0
@onready var sprite_2d = $Sprite2D

func _physics_process(delta):
	if (velocity.x < 0) :
		sprite_2d.animation = "walk-left"
	elif (velocity.x > 0):
		sprite_2d.animation = "walk-right"
	elif (velocity.y > 0) :
		sprite_2d.animation = "walk-front"
	elif (velocity.y < 0):
		sprite_2d.animation = "walk-back"
	
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		if (velocity.x < 0) :
			sprite_2d.animation = "default"
		elif (velocity.x > 0):
			
			sprite_2d.animation = "default-right"
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	direction = Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.y = direction * SPEED
	else:
		if (velocity.y < 0) :
			sprite_2d.animation = "default-back"
		elif (velocity.y > 0):
			sprite_2d.animation = "default-front"
		velocity.y = move_toward(velocity.y, 0, SPEED)

	var collision = move_and_slide()


func _ready():
	var window_interface = JavaScriptBridge.get_interface("window")
	var console_interface = JavaScriptBridge.get_interface("console")
	if window_interface:
		
		# Check if MetaMask is installed and enabled
		# Request access to the user's accounts
		var accounts = await window_interface.ethereum.request({
			"method": "eth_requestAccounts"
		});
		await get_tree().create_timer(1.0).timeout
		
		var sender_address = accounts[0]
		print(sender_address)
	else:
		
		print("Window interface not available")

func try_await():
	await get_tree().create_timer(1.0).timeout
	JavaScriptBridge.eval("alert('hhhh')")
	print("After timout")


