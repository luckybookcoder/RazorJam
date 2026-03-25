extends robot
@export var count = 4##the starting point for the robot, as long as it has that many commands. for every command past this number, the robot will move the front to the back
var text

func _process(delta: float) -> void:
	buggy = 2
	if not moving:
		text = moves.duplicate_deep()
	if g.focus == $".":
		g.text = text
	

func move():
	for i in moves.size():
		if i < count-1:
			moves.append(moves.pop_front())
	super()
