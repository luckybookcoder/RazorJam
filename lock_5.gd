extends lock
var mpos
var moin = false
var dir = Vector2.ZERO
var inputs = []
var length = 1
var combo = []
# Called when the node enters the scene tree for the first time.
func spec() -> void:
	num = 4
	if not locked:
		inputs.clear()
		length = 0
		combo.clear()
		for i in randi_range(4,6):
			combo.append([Vector2.LEFT,Vector2.RIGHT,Vector2.UP,Vector2.DOWN].get(randi()%4))
	else:
		var text = ''
		for i in combo:
			text += {Vector2.LEFT:"L", Vector2.RIGHT:"R", Vector2.UP:"U", Vector2.DOWN:"D"}.get(i)
		phoneify(text)
		if inputs == combo:
			unlock()
		elif inputs.size() == combo.size() or $Reset.button_pressed:
			inputs.clear()
			$Reset.button_pressed = false
			g.tick.emit()
			shuffle()

func shuffle():
	combo.clear()
	for i in randi_range(4,6):
		combo.append([Vector2.LEFT,Vector2.RIGHT,Vector2.UP,Vector2.DOWN].get(randi()%4))

func down():
	inputs.append(Vector2.DOWN)

func left():
	inputs.append(Vector2.LEFT)

func right():
	inputs.append(Vector2.RIGHT)


func up():
	inputs.append(Vector2.UP)
