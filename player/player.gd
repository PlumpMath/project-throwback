extends KinematicBody2D

#----------------------------------------------------------------------------------------------------
# global
#----------------------------------------------------------------------------------------------------

#-------------------------
# registration
#-------------------------

# Internal
onready var data = get_node("data")
onready var model = get_node("model")
onready var weapon = get_node("weapon")


#-------------------------
# variables
#-------------------------

var direction = Vector2()
var speed = 0
const MAX_SPEED = 300
var velocity = Vector2()


#-------------------------
# state
#-------------------------

var hit = false


#----------------------------------------------------------------------------------------------------
# _ready
#----------------------------------------------------------------------------------------------------

func _ready():
	set_process(true)
	set_fixed_process(true)


#----------------------------------------------------------------------------------------------------
# _process
#----------------------------------------------------------------------------------------------------

func _process(delta):

	if (Input.is_action_pressed("weapon_fire")):
		weapon.fire()

	if (Input.is_action_pressed("weapon_reload")):
		weapon.reload()


#----------------------------------------------------------------------------------------------------
# _fixed_process
#----------------------------------------------------------------------------------------------------

func _fixed_process(delta):

	#-------------------------
	# Movement
	#-------------------------

	direction = Vector2()

	# Set Movement & Basic Directions
	if (Input.is_action_pressed("move_left")):
		direction.x = -1
		model.set_rotd(-180)
		weapon.set_rotd(-180)
	elif (Input.is_action_pressed("move_right")):
		direction.x = 1
		model.set_rotd(0)
		weapon.set_rotd(0)

	if (Input.is_action_pressed("move_up")):
		direction.y = -1
		model.set_rotd(90)
		weapon.set_rotd(90)
	elif (Input.is_action_pressed("move_down")):
		direction.y = 1
		model.set_rotd(-90)
		weapon.set_rotd(-90)

	# Set Additional Directions
	if ((Input.is_action_pressed("move_right"))&&(Input.is_action_pressed("move_up"))):
		model.set_rotd(45)
		weapon.set_rotd(45)

	if ((Input.is_action_pressed("move_right"))&&(Input.is_action_pressed("move_down"))):
		model.set_rotd(-45)
		weapon.set_rotd(-45)

	if ((Input.is_action_pressed("move_left"))&&(Input.is_action_pressed("move_up"))):
		model.set_rotd(135)
		weapon.set_rotd(135)

	if ((Input.is_action_pressed("move_left"))&&(Input.is_action_pressed("move_down"))):
		model.set_rotd(-135)
		weapon.set_rotd(-135)


	if (direction != Vector2()):
		speed = MAX_SPEED
		data.state_idle = false
	else:
		speed = 0
		data.state_idle = true

	velocity = speed * direction.normalized() * delta
	move(velocity)


#----------------------------------------------------------------------------------------------------
# end
#----------------------------------------------------------------------------------------------------
