extends StaticBody2D

@onready var button = $Button
@onready var player = $TextEdit
@onready var contract = $TextEdit2 
@onready var node = get_node("/root/Main/Node2D")

func _ready():
	button.pressed.connect(self._button_pressed)

func _button_pressed():
	node.player_num = player.text
	node.contract = contract.text
	print(node.contract)
	self.queue_free()
