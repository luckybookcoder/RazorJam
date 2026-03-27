extends VSlider

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	show()
	if g.lvleditem is int:
		value = 4
	else:
		if g.lvleditem:
			value = 5 - {"CHARGE":0, "WALL":2, "DOOR":3, "GOAL":4, "ITEM":5}[g.lvleditem]
		else:
			hide()
	if g.lvlediting:
		pass
	else:
		hide()
