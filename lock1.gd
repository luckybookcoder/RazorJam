extends lock
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if g.playerpos != &"door":
		position = Vector2(randi()%1000,randi()%500)
	else:
		await pressed
		g.tick.emit()
		if locked == true:
			locked = false
			g.locked -= 1
	num = 1
	if locked:
		show()
	else:
		hide()
