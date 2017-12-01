extends Node2D

#----------------------------------------------------------------------------------------------------
# global
#----------------------------------------------------------------------------------------------------

export var level = ""

onready var message = get_node("/root/gx/hud").content["instruction"]
onready var player = get_node("/root/gx/player")

var timer = null
var can_press = false

var interact = false


#----------------------------------------------------------------------------------------------------
# _ready
#----------------------------------------------------------------------------------------------------

func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(1)
	timer.connect("timeout", self, "_on_timer_timeout")

	can_press = true
	interact = false

	set_process(true)


#----------------------------------------------------------------------------------------------------
# _process
#----------------------------------------------------------------------------------------------------

func _process(delta):

	if ((interact) && (can_press) && (Input.is_action_pressed("interact_a"))):
		can_press = false
		timer.start()

		var target = get_node(str(level)).get_global_pos()
		player.set_global_pos(target)


#----------------------------------------------------------------------------------------------------
# _on_body
#----------------------------------------------------------------------------------------------------

#-------------------------
# enter
#-------------------------

func _on_interact_body_enter( body ):
	interact = true
	get_node("/root/gx/hud").content["instruction"] = "Press SPACE BAR to Use Elevator"


#-------------------------
# exit
#-------------------------

func _on_interact_body_exit( body ):
	interact = false
	get_node("/root/gx/hud").content["instruction"] = ""


#----------------------------------------------------------------------------------------------------
# _on_timeout
#----------------------------------------------------------------------------------------------------

func _on_timer_timeout():
	can_press = true


#----------------------------------------------------------------------------------------------------
# end
#----------------------------------------------------------------------------------------------------
