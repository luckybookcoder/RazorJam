extends VSlider


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	show()
	if g.lvleditem is int:
		value = 1
	else:
		if g.lvleditem:
			value = {"WALL":0, "GOAL":2, "ITEM":3}[g.lvleditem]
		else:
			hide()
	if g.lvlediting:
		pass
	else:
		hide()
