extends robot
@export var count : int ##this robot drops every nth input, where n is dropcount
@export var droppoint = 1 ##if 1: drops the next input. if 0: drops the last input
var poppers = []

func _physics_process(delta: float) -> void:
	super(delta)
	buggy = true
	if g.focus == $".":
		g.text = poppers
	if not moving:
		poppers = moves.duplicate_deep()

func move():
	for i in range(moves.size()-1,-1,-1):
		if (i+1)%count == 0:
			if droppoint == 1:
				moves.pop_at(i)
			else:
				moves.pop_at(moves.size()-1)
	super()
