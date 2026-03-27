extends robot


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _process(a) -> void:
	buggy = 1
	print(buggy)

func move():
	for i in moves.size():
		moves[i] = round(moves[i].rotated(PI/2))
	super()
