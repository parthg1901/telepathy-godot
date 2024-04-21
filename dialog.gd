extends StaticBody2D

@onready var label = $Label
@onready var button = $Button
@onready var node = get_node("/root/Main/Node2D")

func _ready():
	button.pressed.connect(self._button_pressed)

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			label.text = ""
			self.hide()
			button.hide()
func _button_pressed():
	Metamask.restart(Metamask.selected_account(), node.contract)
