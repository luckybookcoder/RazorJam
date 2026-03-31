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
	if g.playerpos == &"box":
		g.truelockposses[num] = null
		unlock()
	if locked:
		g.truelockposses[num] = global_position
		show()
		if not g.locks.has(num):
			g.locks.append(num)
	else:
		if not g.locks.size():
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
			await g.wait(5)
			
			for x in 8:
				for y in 5:
					if Vector2(x,y) != Vector2(7,0):
						g.lockposses.append(Vector2(x,y))
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
		g.locks.erase(num)
	#print(locked, g.locked, g.locks)

func die():
	locked = false
	g.locked = 0

func phoneify(thing):
	g.phonevars[num-1] = thing
	#print(g.phonevars[num-1])
