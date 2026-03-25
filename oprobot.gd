extends robot

func _process(delta: float) -> void:
	if g.playerpos == &"door":
		buggy = 2
	else:
		buggy = 1
	if buggy and g.focus == $".":
		moves.reverse()
		var text = moves
		moves.reverse()
		g.text = moves

func move():
	if not moving:
		moves.reverse()
	super()
