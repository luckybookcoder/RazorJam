extends robot


func _ready() -> void:
	buggy = 1
	super()
func move():
	for i in moves.size():
		if moves[i] is Vector2:
			moves[i] *= -1
	super()
