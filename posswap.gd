extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if g.lvlediting:
		text = "Test your level"
		if (g.robots and g.goals and g.items >= g.goals):
			disabled = false
			tooltip_text = ""
		else:
			if not g.robots:
				tooltip_text = "You need at least one robot!"
			elif not g.goals:
				tooltip_text = "You need at least one goal!"
			else:
				tooltip_text = "You need as many items as goals!"
			disabled = true
	else:
		tooltip_text = ""
		disabled = false
		if g.playerpos == &"box":
			show()
			text = "Go... OUTSIDE THE BOX"
		elif g.playerpos == &"door" and not g.locked:
			show()
			text = "reenter... THE BOX"
		else:
			hide()


func _on_pressed() -> void:
	if g.lvlediting:
		if g.robots and g.goals and g.items >= g.goals:
			g.waiter = false
	else:
		g.waiter = false # Replace with function body.
