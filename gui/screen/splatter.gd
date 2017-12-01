extends Control

onready var player = get_node("/root/gx/player")
onready var animation = get_node("animation")
onready var splatter = get_node("1")


func _ready():
#	splatter.hide()
	set_process(true)


func _process(delta):
	if (player.hit):
		splatter.show()
		animation.play("splatter")

		player.hit = false

