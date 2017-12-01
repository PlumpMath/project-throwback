extends Label

#----------------------------------------------------------------------------------------------------
#
#----------------------------------------------------------------------------------------------------

onready var player = get_node("/root/gx/player/data")
onready var weapon = get_node("/root/gx/player/weapon")

onready var clip = get_node("ammo/clip")
onready var inventory = get_node("ammo/inventory")

func _ready():
	set_process(true)


func _process(delta):
	clip.set_text(str(weapon.clip))
	inventory.set_text(str(" / ", player.inventory_ammo))


#----------------------------------------------------------------------------------------------------
# end
#----------------------------------------------------------------------------------------------------
