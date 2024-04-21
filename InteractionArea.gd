extends Area2D
class_name InteractionArea
@onready var node = get_node("/root/Main/Node2D")
@export var action_name: String = "interact"

var interact: Callable = func ():
	if get_parent().get_name().find("V") != -1:
		print(get_parent().get_name().split("r")[1])
		Metamask.get_lives(Metamask.selected_account() ,node.contract)
	else:
		Metamask.interact(Metamask.selected_account(), node.contract, int(get_parent().get_parent().get_name().split("i")[1])-1, 1)

func _on_body_entered(body):
	InteractionManager.register_area(self)


func _on_body_exited(body):
	InteractionManager.unregister_area(self)
