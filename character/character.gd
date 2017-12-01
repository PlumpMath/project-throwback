extends KinematicBody2D

#----------------------------------------------------------------------------------------------------
# globals
#----------------------------------------------------------------------------------------------------

export var bite = 5


#-------------------------
# registration
#-------------------------

# External
onready var player = get_node("/root/gx/player")
onready var hud = get_node("/root/gx/hud")

# Internal
onready var model = get_node("model")
onready var raycast = get_node("raycast")
onready var data = get_node("data")
onready var wound = get_node("wound")

# Instance
onready var blood = get_node("res://world/particle/blood.tscn")
onready var footprint = get_node("res://world/particle/footprint.tscn")

var timer_footprint
var can_footprint = true


#-------------------------
# export
#-------------------------

export var id = 0
export var type = "NPC"
export var name = ""
export (Texture) var texture


#-------------------------
# variables
#-------------------------

var direction = Vector2()
var speed = 0
const MAX_SPEED = 100
var velocity = Vector2()


#-------------------------
# state
#-------------------------

var detected = false


#----------------------------------------------------------------------------------------------------
# _ready
#----------------------------------------------------------------------------------------------------

func _ready():

	# Init
	get_node("model").set_texture(texture)
	detected = false

	set_process(true)
	set_fixed_process(true)


#----------------------------------------------------------------------------------------------------
# _process
#----------------------------------------------------------------------------------------------------

func _process(delta):
	get_node("content").set_text(str(name))


	if (data.physical_health <= 0):
		get_node("/root/gx/data").enemies_killed += 1
		queue_free()

	get_node("health").set_value(data.physical_health)

	if (can_footprint):
		footprint()


#----------------------------------------------------------------------------------------------------
# _fixed_process
#----------------------------------------------------------------------------------------------------

func _fixed_process(delta):

	#-------------------------
	# movement
	#-------------------------

	direction = Vector2()
#	var player = get_node("/root/gx/player")

	if (detected):

		if (player.get_global_pos().x < self.get_global_pos().x):
			direction.x = -1
			model.set_rotd(180)
			raycast.set_rotd(-90)

		if (player.get_global_pos().x >self.get_global_pos().x):
			direction.x = 1
			model.set_rotd(0)
			raycast.set_rotd(90)

		if (player.get_global_pos().y < self.get_global_pos().y):
			direction.y = -1
			model.set_rotd(90)
			raycast.set_rotd(-180)

		if (player.get_global_pos().y > self.get_global_pos().y):
			direction.y = 1
			model.set_rotd(-90)
			raycast.set_rotd(0)

		# Extra Angles
		if ((player.get_global_pos().x >self.get_global_pos().x)&&(player.get_global_pos().y < self.get_global_pos().y)):
			model.set_rotd(45)
			raycast.set_rotd(135)

		if ((player.get_global_pos().x >self.get_global_pos().x)&&(player.get_global_pos().y > self.get_global_pos().y)):
			model.set_rotd(-45)
			raycast.set_rotd(-135)

		if ((player.get_global_pos().x < self.get_global_pos().x)&&(player.get_global_pos().y < self.get_global_pos().y)):
			model.set_rotd(135)
			raycast.set_rotd(-90)

		if ((player.get_global_pos().x < self.get_global_pos().x)&&(player.get_global_pos().y > self.get_global_pos().y)):
			model.set_rotd(-135)
			raycast.set_rotd(-90)


	if (direction != Vector2()):
		speed = MAX_SPEED
	else:
		speed = 0


	velocity = speed * direction.normalized() * delta
	move(velocity)


#----------------------------------------------------------------------------------------------------
# _on_detect_body
#----------------------------------------------------------------------------------------------------

#-------------------------
# enter
#-------------------------

func _on_detect_body_enter( body ):

	if (body.get_groups().has("player")):
		detected = true


#-------------------------
# exit
#-------------------------

func _on_detect_body_exit( body ):
	get_node("timer").start()


#-------------------------
# timeout
#-------------------------

func _on_timer_timeout():
	detected = false


#----------------------------------------------------------------------------------------------------
# _on_interact_body
#----------------------------------------------------------------------------------------------------

#-------------------------
# enter
#-------------------------

func _on_interact_body_enter( body ):
	var player = get_node("/root/gx/player/data")

	player.physical_health -= bite
	get_node("/root/gx/player").hit = true


#-------------------------
# exit
#-------------------------

func _on_interact_body_exit( body ):
	pass # replace with function body


#----------------------------------------------------------------------------------------------------
# hit
#----------------------------------------------------------------------------------------------------

func hit(damage):

#	data.physical_health = data.physical_health -damage
	data.physical_health -= damage

	var animation = get_node("hit/animation")
	animation.play("show")

	get_node("blood").show()

	var world = get_node("/root/gx/world/map/main/splatter")
	var splatter = load("res://world/particle/splatter.tscn")
	var scene = splatter.instance()
	var position = self.get_global_pos()
	scene.set_global_pos(position)
	world.add_child(scene)
#	wound.add_child(scene)

	get_node("hit").damage = damage
	#get_node("hit/damage").set_text(str("Bob"))


#----------------------------------------------------------------------------------------------------
# footprint
#----------------------------------------------------------------------------------------------------

func footprint():
	var world = get_node("/root/gx/world/map/main/splatter")
	var footprint = load("res://world/particle/footprint.tscn")
	var scene = footprint.instance()
	var position = self.get_global_pos()
	var rotation = model.get_global_rotd()
	scene.set_global_pos(position)
	scene.set_rotd(rotation)
	world.add_child(scene)

	can_footprint = false

	timer_footprint = Timer.new()
	timer_footprint.set_one_shot(true)
	timer_footprint.set_wait_time(2)
	timer_footprint.connect("timeout", self, "_on_timer_footprint_timeout")
	get_node("footprint").add_child(timer_footprint)
	timer_footprint.start()


#-------------------------
# timeout
#-------------------------

func _on_timer_footprint_timeout():
	can_footprint = true


#----------------------------------------------------------------------------------------------------
# end : version 1.7.2 / updated 11/24/2017
#----------------------------------------------------------------------------------------------------
