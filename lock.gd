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
		g.truelockposses[num] = global_position
		show()
		if not g.locks.has(num):
			g.locks.append(num)
	else:
		g.truelockposses[num] = null
		hide()
	spec()
	if not locked:
		pos = Vector2(randi()%8, randi()%5)
		posset = true
	else:
		if posset:
			posset = false
			pos = g.lockposses.pop_at(randi()%g.lockposses.size())
			#for i in num:
				#await get_tree().process_frame
			#while g.lockposses.has(pos):
				#hide()
				#pos = Vector2(randi()%8, randi()%5)
				#
			#g.lockposses.append(pos)
			#print(g.lockposses)
			#if g.lockposses.size() == 7:
				#g.lockposses.clear()
				#g.lockposses.append(Vector2(6,0))
				#g.lockposses.append(Vector2(7,0))
				#g.lockposses.append(Vector2(7,4))
				#g.lockposses.append(Vector2(7,3))
			position = pos*128 
			await get_tree().process_frame
			if true:
				g.lockposses = [Vector2(0,0),Vector2(1,0),Vector2(2,0),Vector2(5,0),Vector2(7,0),Vector2(0,1),Vector2(1,1),Vector2(2,1),Vector2(3,1),Vector2(4,1),Vector2(5,1),Vector2(6,1),Vector2(7,1),Vector2(0,2),Vector2(1,2),Vector2(2,2),Vector2(3,2),Vector2(4,2),Vector2(5,2),Vector2(6,2),Vector2(7,2),Vector2(0,3),Vector2(1,3),Vector2(2,3),Vector2(3,3),Vector2(4,3),Vector2(5,3),Vector2(6,3),Vector2(0,4),Vector2(1,4),Vector2(2,4),Vector2(3,4),Vector2(4,4),Vector2(5,4),Vector2(6,4),]

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
		if not g.realtime:
			g.tick.emit()

func die():
	locked = false
	g.locked = 0

func phoneify(thing):
	g.phonevars[num-1] = thing
	#print(g.phonevars[num-1])
