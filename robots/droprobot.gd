extends robot
@export var count : int ##this robot drops every nth input, where n is dropcount
@export var droppoint = 1
var poppers = []
func move():
	for i in range(moves.size()-1,-1,-1):
		if (i+1)%count == 0:
			if droppoint == 1:
				moves.pop_at(i)
			else:
				moves.pop_at(moves.size()-1)
	super()
