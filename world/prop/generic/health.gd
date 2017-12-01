extends Area2D

#----------------------------------------------------------------------------------------------------
# global
#----------------------------------------------------------------------------------------------------

export var amount = 0
export (Texture) var texture

onready var hud = get_node("/root/gx/hud")
onready var player = get_node("/root/gx/player/data")

var interact = false


#----------------------------------------------------------------------------------------------------
# _ready
#----------------------------------------------------------------------------------------------------

func _ready():
	get_node("model").set_texture(texture)
	set_process(true)


#----------------------------------------------------------------------------------------------------
# _process
#----------------------------------------------------------------------------------------------------

func _process(delta):
	if (interact):
		if (Input.is_action_pressed("interact_a")):
			player.physical_health += amount
			#player.physical_health = player.physical_health + amount
			hud.content["message"] = "%s Health added" % amount
			self.queue_free()


#----------------------------------------------------------------------------------------------------
# _on_body
#----------------------------------------------------------------------------------------------------

#-------------------------
# enter
#-------------------------

func _on_health_body_enter( body ):
	interact = true
	get_node("/root/gx/hud").content["instruction"] = "Press SPACE BAR to Pickup %s Health" % amount


#-------------------------
# exit
#-------------------------

func _on_health_body_exit( body ):
	interact = false
	get_node("/root/gx/hud").content["instruction"] = ""


#----------------------------------------------------------------------------------------------------
# end
#----------------------------------------------------------------------------------------------------
