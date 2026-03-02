extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if g.playerpos == &"box":
		show()
		text = "Go... OUTSIDE THE BOX"
	elif g.playerpos == &"door" and not g.locked:
		show()
		text = "reenter... THE BOX"
	else:
		hide()


func _on_pressed() -> void:
	g.waiter = false # Replace with function body.
