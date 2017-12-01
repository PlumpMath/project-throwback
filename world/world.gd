extends Node2D

var select = ""

func _ready():
	pass
#	location("ground1")


func location(select):

	var container = get_node("container")
	var level_current = load("res://world/level/ground1.tscn")
	var level_previous = container.get_children()

	print("level_current: ", level_current)
	print("level_previous: ", level_previous)

	level_previous.queue_free()
	var level = level_current.instance()
	container.add_child(level)

