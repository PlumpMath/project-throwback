extends Node2D

#----------------------------------------------------------------------------------------------------
# global
#----------------------------------------------------------------------------------------------------

export var destination = ""
export var content = ""

onready var hud = get_node("/root/gx/hud")
onready var player = get_node("/root/gx/player")

onready var status = get_node("status")


#-------------------------
# state
#-------------------------

var can_press = null
var interact = false


#----------------------------------------------------------------------------------------------------
# _ready
#----------------------------------------------------------------------------------------------------

func _ready():
	set_process(true)


#----------------------------------------------------------------------------------------------------
# _process
#----------------------------------------------------------------------------------------------------

func _process(delta):

	can_press = get_node("../").can_press

	if ((interact) && (can_press) && (Input.is_action_pressed("interact_a"))):

		var position = get_node(destination).get_global_pos()
		player.set_global_pos(position)

		get_node("../").can_press = false
		get_node("../").in_motion = true

		hud.content["location"] = content


	# Internal Status
	var display_can_press = get_node("../").can_press
	var display_in_motion = get_node("../").in_motion

	status.set_text(str(interact, display_can_press, display_in_motion))


#----------------------------------------------------------------------------------------------------
# _on_body
#----------------------------------------------------------------------------------------------------

#-------------------------
# enter
#-------------------------

func _on_interact_body_enter( body ):
	interact = true
	get_node("/root/gx/hud").content["instruction"] = "Press A to Use the Elevator"


#-------------------------
# exit
#-------------------------

func _on_interact_body_exit( body ):
	interact = false
	can_press = true
	get_node("/root/gx/hud").content["instruction"] = ""


#----------------------------------------------------------------------------------------------------
# end
#----------------------------------------------------------------------------------------------------
