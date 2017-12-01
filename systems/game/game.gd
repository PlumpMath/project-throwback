extends Node2D

#----------------------------------------------------------------------------------------------------
# globals
#----------------------------------------------------------------------------------------------------

#-------------------------
# ingredients container
#-------------------------

var ingredients = 0


#-------------------------
# supplies container
#-------------------------

var supplies = 0


#-------------------------
# state
#-------------------------

var state_ingredients_complete = false
var state_supplies_complete = false
var state_game_complete = false


#----------------------------------------------------------------------------------------------------
# _ready
#----------------------------------------------------------------------------------------------------

func _ready():
	get_node("hud").content["location"] = ""
	get_node("hud").content["message"] = ""
	get_node("hud").content["instruction"] = ""

	get_node("music_game").play()

	print("game running: Project Throwback")

	set_process(true)


#----------------------------------------------------------------------------------------------------
# _process
#----------------------------------------------------------------------------------------------------

func _process(delta):


	if (ingredients == 5):
		state_ingredients_complete = true
		get_node("hud").content["message"] = "You've found all the ingredients, search for the rest of the supplies to complete the antidote."

	if (supplies == 5):
		state_supplies_complete = true
		get_node("hud").content["message"] = "You've found all the supplies, seach for the rest of the ingredients to complete the antidote."

	if ((state_ingredients_complete) && (state_supplies_complete)):
		state_game_complete = true
		get_node("hud").content["message"] = "Success!"

	get_node("label").set_text(str(state_ingredients_complete, " / ", state_supplies_complete, "(", supplies, ") / ", state_game_complete))

	var player = get_node("player/data")

	if (player.physical_health <= 0):
		get_node("hud/fail").show()

	if (state_game_complete):
		get_node("hud/success").show()
		get_node("music_game").stop()
		get_node("music_success").play()


#----------------------------------------------------------------------------------------------------
# end
#----------------------------------------------------------------------------------------------------
