extends Node

onready var game = get_node("/root/gx")
onready var player = get_node("/root/gx/player")
onready var world = get_node("/root/gx/world")
onready var hud = get_node("/root/gx/hud")
onready var menu = get_node("/root/gx/menu")

onready var timer = get_node("timer")
var can_timer = true
var timer_phase
var phase = 0

var state_init = true

func _ready():
	phase = 1
	set_process(true)


func _process(delta):
	if (state_init):
		if (phase == 1):
			hud.content["message"] = "It's dangerous to go alone. Search the room for supplies before exploring the rest of the facility."
			hud.content["instruction"] = ""
			hud.content["dialogue"] = "Player: I can't believe he just bit me. What is going on?"
			hud.content["location"] = "Ground Floor"
			if (can_timer):
				delay(3)

		elif (phase == 2):
			hud.content["dialogue"] = "Player: I can't believe I shot him ... I've never killed anyone before."
			if (can_timer):
				delay(3)

		elif (phase == 3):
			hud.content["dialogue"] = "Player: His eyes ... Oh God, I hope he wasn't exposed ... I hope I wasn't exposed."
			if (can_timer):
				delay(3)

		elif (phase == 4):
			hud.content["dialogue"] = "Player: What do I do now?"
			if (can_timer):
				delay(3)

		elif (phase == 5):
			hud.content["dialogue"] = "Player: I lost a lot of blood ... I don't feel so good."
			if (can_timer):
				delay(3)

		elif (phase == 6):
			hud.content["dialogue"] = "Player: What's that over there?"
			if (can_timer):
				delay(3)

		elif (phase == 7):
			hud.content["dialogue"] = ""
			queue_free()


func delay(duration):
	if (can_timer):
		timer_phase = Timer.new()
		timer_phase.set_one_shot(true)
		timer_phase.set_wait_time(duration)
		timer_phase.connect("timeout", self, "_on_timer_phase_timeout")
		timer.add_child(timer_phase)
		timer_phase.start()
		can_timer = false

func _on_timer_phase_timeout():
	phase += 1
	can_timer = true
	timer_phase.queue_free()
