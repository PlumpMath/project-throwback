extends Node2D

var timer

func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(30)
	timer.connect("timeout", self, "_on_timer_timeout")
	add_child(timer)
	timer.start()

func _on_timer_timeout():
	queue_free()
