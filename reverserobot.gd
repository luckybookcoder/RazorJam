extends robot


func _process(delta: float) -> void:
	buggy = 1
func move():
	for i in moves.size():
		if moves[i] is Vector2:
			moves[i] *= -1
	super()
