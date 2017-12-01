extends Area2D

#----------------------------------------------------------------------------------------------------
# global
#----------------------------------------------------------------------------------------------------

#onready var game = get_node("/root/gx")
onready var game = get_node("/root/gx")
onready var hud = get_node("/root/gx/hud")

export var id = ""
export var name = ""
export (Texture) var texture
var interact = false


#----------------------------------------------------------------------------------------------------
# _ready
#----------------------------------------------------------------------------------------------------

func _ready():
	get_node("model").set_texture(texture)
	interact = false

	set_process(true)


#----------------------------------------------------------------------------------------------------
# _process
#----------------------------------------------------------------------------------------------------

func _process(delta):

	if (interact):
		if (Input.is_action_pressed("interact_a")):
			game.ingredients += 1
			var count = 5 - game.ingredients
			hud.content["message"] = str("You picked up the %s. There are %s ingredients remaining." % [name, count])
			queue_free()


#----------------------------------------------------------------------------------------------------
# _on_body
#----------------------------------------------------------------------------------------------------

#-------------------------
# enter
#-------------------------

func _on_ingredient_body_enter( body ):
	interact = true
	get_node("/root/gx/hud").content["instruction"] = "Press SPACE BAR to Pickup %s of 5 Ingredient" % id


#-------------------------
# exit
#-------------------------

func _on_ingredient_body_exit( body ):
	interact = false
	get_node("/root/gx/hud").content["instruction"] = ""

#----------------------------------------------------------------------------------------------------
# end
#----------------------------------------------------------------------------------------------------
