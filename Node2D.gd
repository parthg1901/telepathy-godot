extends Node2D

@export var contract = ""
@export var user_lives = 0
@export var player_num = 0
var _window = JavaScriptBridge.get_interface("window")
@onready var label = get_node("Dialog")
@onready var label2 = get_node("Dialog2")

# Called when the node enters the scene tree for the first time.
func _ready():
	if _window:
		label2.show()
		Metamask.request_accounts()
		if Metamask.selected_account():
			JavaScriptBridge.eval("alert('Connected')")
			Metamask.connect("get_lives_finished", _on_get_lives_finished)
			Metamask.connect("get_response_finished", _on_get_response_finished)
			Metamask.connect("interact_finished", _on_interact_finished)
			Metamask.connect("get_interact_response_finished", _on_get_interact_response_finished)
			Metamask.connect("restart_finished", _on_restart_finished)

func _on_get_lives_finished(response):
	if response.error != null:
		JavaScriptBridge.eval("alert('Error')")
		return
	await get_tree().create_timer(10.0).timeout
	Metamask.get_response(contract)

func _on_get_response_finished(response):
	if response.error != null:
		JavaScriptBridge.eval("alert('Error')")
		return
	var lives = response.result[131]
	user_lives = int(lives)
	label.show()
	label.label.text = "You have " + lives + " lives"

func _on_interact_finished(response):
	if response.error != null:
		JavaScriptBridge.eval("alert('Error')")
		return
	await get_tree().create_timer(20.0).timeout	
	Metamask.get_interact_response(contract)

func _on_get_interact_response_finished(response):
	if response.error != null:
		JavaScriptBridge.eval("alert('Error')")
		return
	var out = int(response.result[131])
	var text = ""	
	if out == 4:
		label.label.text = "No Lives Left"
	elif out == 2:
		label.label.text = "You were killed by Sensei"
	elif out == 1:
		label.label.text = "Good Job! You impressed every Sensei"
		label.button.show()
	elif out == 3:
		label.label.text = "You survived the Sensei Attack"
	label.show()

func _on_restart_finished(response):
	if response.error != null:
		JavaScriptBridge.eval("alert('Error')")
		return
