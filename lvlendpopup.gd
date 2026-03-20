extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Popup/Reset.button_down.connect(same) # Replace with function body.
	$Popup/Continue.button_down.connect(next)


# Called every frame. 'delta' is the elapsed time since the previous frame.

func next():
	g.endlvl.emit()
	print("AAA")

func same():
	if g.lvl is int:
		g.lvl -= 1
	g.endlvl.emit()
