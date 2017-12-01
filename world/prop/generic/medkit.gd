extends Area2D

#----------------------------------------------------------------------------------------------------
#
#----------------------------------------------------------------------------------------------------

onready var player = get_node("/root/gx/player/data")
onready var message = get_node("label")

var interact = false

func _ready():
	set_process(true)

func _process(delta):
	if (interact):
		if (Input.is_action_pressed("interact_a")):
			player.physical_health = player.physical_health +25
			self.queue_free()


#----------------------------------------------------------------------------------------------------
# end
#----------------------------------------------------------------------------------------------------


func _on_medkit_body_enter( body ):
	interact = true
	message.set_text(str("Press A to Pickup"))


func _on_medkit_body_exit( body ):
	interact = false
	message.set_text(str(""))
