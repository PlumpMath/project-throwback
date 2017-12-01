extends Control

onready var data = get_node("/root/gx/data")
onready var stats_bullets = get_node("stats/bullets")
onready var stats_kills = get_node("stats/kills")
onready var stats_supplies = get_node("stats/supplies")
onready var stats_ingredients = get_node("stats/ingredients")


func _ready():
	set_process(true)


func _process(delta):
	stats_bullets.set_text(str("Bullets Fired: ", data.bullets_fired))
	stats_kills.set_text(str("Infected Killed: ", data.enemies_killed))

	stats_supplies.set_text(str("Supplies Collected: 5 of 5"))
	stats_ingredients.set_text(str("Ingredients Collects: 5 of 5"))
