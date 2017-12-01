extends Node2D

#----------------------------------------------------------------------------------------------------
# global
#----------------------------------------------------------------------------------------------------

onready var player = get_node("/root/gx/player/data")
onready var hud = get_node("/root/gx/hud")
onready var bullet = load("res://world/prop/weapon/bullet.tscn")
onready var barrel = get_node("barrel")
onready var audio = get_node("audio")

onready var fire = get_node("fire")
onready var reload = get_node("reload")

var clip = 2
var clip_capacity = 12

var rate_fire = 1
var rate_reload = 3

var timer_fire
var timer_reload

var can_fire = true
var can_reload = true

var damage = 25

#----------------------------------------------------------------------------------------------------
# fire
#----------------------------------------------------------------------------------------------------

func fire():

	if (can_fire):
		if (clip == 0):
			audio.play("fire_empty")
			can_fire = false
		else:
			var b = bullet.instance()
			barrel.add_child(b)
			audio.play("barreta_m9_fire")
			can_fire = false

			# Subtrack from clip
			clip -= 1

		# Create cooldown timer
		timer_fire = Timer.new()
		timer_fire.set_one_shot(true)
		timer_fire.set_wait_time(rate_fire)
		timer_fire.connect("timeout", self, "_on_timer_fire_timeout")
		fire.add_child(timer_fire)
		timer_fire.start()

		get_node("/root/gx/data").bullets_fired += 1

#-------------------------
# _on_timeout
#-------------------------

func _on_timer_fire_timeout():
	can_fire = true


#----------------------------------------------------------------------------------------------------
# reload
#----------------------------------------------------------------------------------------------------

func reload():
	if (can_reload):
		player.inventory_ammo += clip
		clip = 0

		if (player.inventory_ammo >= clip_capacity):
			player.inventory_ammo -= clip_capacity
			clip = clip_capacity
		else:
			clip = player.inventory_ammo
			player.inventory_ammo = 0

		can_reload = false

		# Create cooldown timer
		timer_reload = Timer.new()
		timer_reload.set_one_shot(true)
		timer_reload.set_wait_time(rate_reload)
		timer_reload.connect("timeout", self, "_on_timer_reload_timeout")
		reload.add_child(timer_reload)
		timer_reload.start()

		audio.play("reload")


	if ((player.inventory_ammo == 0)&&(clip == 0)):
		hud.content["message"] = "You are out of ammo"


#-------------------------
# _on_timeout
#-------------------------

func _on_timer_reload_timeout():
	can_reload = true


#----------------------------------------------------------------------------------------------------
# end : version 1.3.0 / updated 11/24/2017
#----------------------------------------------------------------------------------------------------
