extends lock
var order = [0,1,2,3,4,5,9,6,7,8]
var pointer = 0

func _ready() -> void:
	super()
	for i in get_children():
		i.pressed.connect(Callable(self,i.name))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func spec() -> void:
	num = 3
	if not locked:
		pointer = 0
		black()
	var phone = ""
	for i in order.size():
		phone += str(order[i]+1)
		if i%2 == 0:
			if order[i] == 9:
				phone += (" ")
			else:
				phone += ("   ")
		else:
			phone += ("\n")
	if locked:
		phoneify(phone)
	if pointer == 10:
		unlock()

func black():
		for i in get_children():
			i.modulate = Color(0.0, 0.0, 0.0, 1.0)
		order.shuffle()

func Button1():
	if order[0] <= pointer:
		pointer = max(pointer, order[0]+1)
		$Button1.modulate = Color(0.0, 18.892, 0.0, 1.0)
	else:
		pointer = 0
		g.tick.emit()
		black()

func Button2():
	if order[1] <= pointer:
		pointer = max(pointer, order[1]+1)
		$Button2.modulate = Color(0.0, 18.892, 0.0, 1.0)
	else:
		pointer = 0
		g.tick.emit()
		black()

func Button3():
	if order[2] <= pointer:
		pointer = max(pointer, order[2]+1)
		$Button3.modulate = Color(0.0, 18.892, 0.0, 1.0)
	else:
		pointer = 0
		g.tick.emit()
		black()

func Button4():
	if order[3] <= pointer:
		pointer = max(pointer, order[3]+1)
		$Button4.modulate = Color(0.0, 18.892, 0.0, 1.0)
	else:
		pointer = 0
		g.tick.emit()
		black()

func Button5():
	if order[4] <= pointer:
		pointer = max(pointer, order[4]+1)
		$Button5.modulate = Color(0.0, 18.892, 0.0, 1.0)
	else:
		pointer = 0
		g.tick.emit()
		black()

func Button6():
	if order[5] <= pointer:
		pointer = max(pointer, order[5]+1)
		$Button6.modulate = Color(0.0, 18.892, 0.0, 1.0)
	else:
		pointer = 0
		g.tick.emit()
		black()

func Button7():
	if order[6] <= pointer:
		pointer = max(pointer, order[6]+1)
		$Button7.modulate = Color(0.0, 18.892, 0.0, 1.0)
	else:
		pointer = 0
		g.tick.emit()
		black()

func Button8():
	if order[7] <= pointer:
		pointer = max(pointer, order[7]+1)
		$Button8.modulate = Color(0.0, 18.892, 0.0, 1.0)
	else:
		pointer = 0
		g.tick.emit()
		black()

func Button9():
	if order[8] <= pointer:
		pointer = max(pointer, order[8]+1)
		$Button9.modulate = Color(0.0, 18.892, 0.0, 1.0)
	else:
		pointer = 0
		g.tick.emit()
		black()

func Button10():
	if order[9] <= pointer:
		pointer = max(pointer, order[9]+1)
		$Button10.modulate = Color(0.0, 18.892, 0.0, 1.0)
	else:
		pointer = 0
		g.tick.emit()
		black()
