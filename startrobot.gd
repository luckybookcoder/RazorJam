extends robot
@export var startpoint = 4
var text

func _process(delta: float) -> void:
	buggy = true
	if not moving:
		text = moves.duplicate_deep()
	if g.focus == $".":
		g.text = text
	

func move():
	for i in moves.size():
		if i < startpoint-1:
			moves.append(moves.pop_front())
	super()

#func move2():
