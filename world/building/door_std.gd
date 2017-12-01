extends Node2D

#----------------------------------------------------------------------------------------------------
# global
#----------------------------------------------------------------------------------------------------

onready var animation = get_node("animation")

var timer = null
var can_press = false

var state_opened = false
var state_closed = true

var interact = false


#----------------------------------------------------------------------------------------------------
# _ready
#----------------------------------------------------------------------------------------------------

func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(1.5)
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

		if (state_opened):
			animation.play("closing")
			state_opened = false
			state_closed = true

		elif (state_closed):
			animation.play("opening")
			state_opened = true
			state_closed = false


#----------------------------------------------------------------------------------------------------
# _on_body
#----------------------------------------------------------------------------------------------------

#-------------------------
# enter
#-------------------------

func _on_interact_body_enter( body ):
	interact = true
	get_node("/root/gx/hud").content["instruction"] = "Press SPACE BAR to Open Door"


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
