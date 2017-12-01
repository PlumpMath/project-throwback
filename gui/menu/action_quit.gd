extends Button

export var label = ""

func _ready():
	set_text(str(label))


func _on_action_quit_pressed():
	get_tree().quit()

