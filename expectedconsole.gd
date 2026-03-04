extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if g.ticksleft > 0:
		text = str("Expected moves left in selected robot: ", g.ticksleft)
	else:
		text = "No moves left in selected robot. "
	g.ticksleft = 0
