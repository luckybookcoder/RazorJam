extends robot


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func move():
	for i in moves.size():
		if moves[i] is Vector2:
			moves[i] *= -1
	super()
