extends robot

func _process(delta: float) -> void:
	if g.playerpos == &"door":
		buggy = true
	else:
		buggy = false
	if buggy and g.focus == $".":
		moves.reverse()
		var text = moves
		moves.reverse()
		g.text = moves

func move():
	if not moving:
		moves.reverse()
	super()
