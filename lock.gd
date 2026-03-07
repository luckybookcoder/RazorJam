extends Control
class_name lock
var locked = false
var num
var pos = Vector2(0,0)
var posset = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	g.lock.connect(locker)
	g.endlvl.connect(die) # Replace with function body.

func _process(delta: float) -> void:
	if locked:
		show()
		if not g.locks.has(num):
			g.locks.append(num)
	else:
		hide()
	spec()
	if not locked:
		pos = Vector2(randi()%8, randi()%5)
		posset = true
	else:
		if posset:
			posset = false
			while g.lockposses.has(pos):
				hide()
				pos = Vector2(randi()%8, randi()%5)
				await get_tree().process_frame
			g.lockposses.append(pos)
			if g.lockposses.size() == 5:
				g.lockposses.clear()
				g.lockposses.append(Vector2(6,0))
				g.lockposses.append(Vector2(7,0))
			position = pos*128 
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func spec():
	pass

func locker(a,b,c):
	print("AAAAAAAAA")
	if [a,b,c].has(num):
		locked = true

func unlock():
	if locked == true:
		locked = false
		g.locked -= 1
		g.tick.emit()

func die():
	locked = false
	g.locked = 0

func phoneify(thing):
	g.phonevars[num-1] = thing
	#print(g.phonevars[num-1])
