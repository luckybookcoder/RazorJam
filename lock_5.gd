extends lock
var mpos
var moin = false
var dir = Vector2.ZERO
var inputs = []
var length = 1
var combo = []
# Called when the node enters the scene tree for the first time.
func spec() -> void:
	num = 5
	if not locked:
		inputs.clear()
		length = 0
		combo.clear()
		for i in randi_range(3,5):
			combo.append([Vector2.LEFT,Vector2.RIGHT,Vector2.UP,Vector2.DOWN].get(randi()%4))
	else:
		if inputs == combo:
			unlock()
		elif inputs.size() == combo.size():
			inputs.clear()
			g.tick.emit()


func down():
	inputs.append(Vector2.DOWN)

func left():
	inputs.append(Vector2.LEFT)

func right():
	inputs.append(Vector2.RIGHT)


func up():
	inputs.append(Vector2.UP)
