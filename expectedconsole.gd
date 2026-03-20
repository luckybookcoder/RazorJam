extends RichTextLabel
var tick = -1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if g.longest != tick:
		tick = g.longest
		await get_tree().process_frame
		if g.longest != 0:
			text = str("Expected moves left in longest command list: ", g.longest)
		else:
			text = "No moves left in any robot. "
#	print(g.ticksleft)
	g.ticksleft = 0
	if g.playerpos == &"door":
		show()
	else:
		hide()
