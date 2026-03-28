extends Node
@warning_ignore_start("unused_signal")
signal endlvl
signal tick
signal lvltext
signal move
signal lock
var lvlitems = {7:load("lvl8.tscn"),9:load("lvl5.tscn"),5:load("lvl6.tscn"), 6:load("res://lvl_7.tscn"), 4:load("res://lvl4.tscn"),3:load("lvl3.tscn"), 2:load("res://lvl2.tscn"), 1:load("res://lvl1.tscn"), "editor":load("res://lvl_editor.tscn")}
var lvleditem
var truelockposses = {}
var ticksleft = 0
var lvlediting = false
var onitem = false
var ondoor = false
var ongoal = false
var oncharge = false
const goaltypes = {"books":"bookshelf", "laundry":"hamper", "dishes":"dishwasher"}
var text = []
var lvleditsize = Vector2.ZERO
var robots = true
var items = 0
var held = ""
var reset = true
var reset1 = true
var reset2 = true
var locks = []
var phonevars = ["0",0,"0",'0','0','0','0','0','0']
var oldtime = 0
var automove = true
var lockposses = []
var lastmoves = []
var itemtype = ["books", "laundry", "dishes"][randi()%3]
var lvl = 1
var phone = ''
var targettime = {
	1:6.0,
	2:17.0,
	3:13.0,
	4:22.0,
	5:19.0,
	6:8.0,
	7:17.0
}
var goals = 0
var earned = {}
var reward = {
	#Basic robots
	1:100, #load("res://lvl1.tscn"),
	2:135, #load("res://lvl2.tscn"),
	3:170, #load("lvl3.tscn"),
	#Glitches
	4:200, #load("res://lvl4.tscn"),
	5:240, #load("lvl6.tscn"),
	6:280, #
	#Dores
	7:310, #load("res://lvl_7.tscn"),
	8:350, #load("lvl8.tscn"),
	9:390, #load("lvl5.tscn"),
	#Chargers
	10:520,#
	11:560,#
	12:600,#
	}
var longest = 0
var tickwait = false
var newposses = []
var playerpos = &"box"
var locked = 0
var pointer = 0
var focus
var waiter = false
var time = 0
var timeup = 0
var itemposses := {}
var simplemode = false
var realtime = 0
var volume = 1
var lvlsdone = {0:true}
var realtimetick = 0
var realtimecheck = true
var realtimetime = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	for x in 8:
		for y in 5:
			if Vector2(x,y) != Vector2(7,0):
				g.lockposses.append(Vector2(x,y))
	for i in 12:
		lvlsdone.get_or_add(i+1, true)
	tick.connect(ticker)
	lvltext.connect(cash)
# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if realtime and (playerpos == "door" or playerpos == "box"):
		match playerpos:
			"door":
				realtimetick += delta
			"box":
				realtimetick += delta/3
	if realtimetick >= 10:
		realtimer()
	if locked:
		phonetext()
	if reset1 and reset2:
		reset = true
	if timeup:
		timeup = 0
		timer()
	await get_node("/root/Main/Canla/posswap").button_down
	await get_node("/root/Main/Canla/posswap").button_up
	if lvlediting:
		if not waiter:
			lvlediting = false
			waiter = true
	elif playerpos == &"box":
		if not waiter:
			playerpos = &"door"
			move.emit()
			locks.clear()
			var rand = []
			#rand = [1,2,3,4,5,6,7,8,9]
			if lvl is String:
				rand = [1,2,3,4,5,6,7,8,9]
			else:
				if lvl > 4:
					rand = [1,2,3,4,5,6,7,8,9]
				elif lvl > 1:
					for i in lvl*2:
						rand.append(i+1)
				else:
					rand = [1,2,3]
			if simplemode:
				for i in range(rand.size(), -1, -1):
					if i >= 6:
						rand.pop_back()
				print(rand)
			rand.shuffle()
			var a = rand.pop_front()
			var b = rand.pop_front()
			var c = rand.pop_front()
			lock.emit(a,b,c)
			print([a,b,c].has(1))
			locked = 3
			locks.clear()
	elif not locked:
		if automove:
			for i in longest:
				print("?")
				#if i > 30:
					#break
				await get_tree().process_frame
				tick.emit()
				
			
		print(playerpos)
		waiter = true
		playerpos = &"box"
		focus = null
	

func wait(sec:float):
	await get_tree().create_timer(sec).timeout

func phonetext():
	phone = ""
	for i in 9:
		if locks.has(i+1):
			phone += ([str("correct keyhole:", "\n\n%s" %phonevars[0]), "Combo:%03d"%[phonevars[1]],phonevars[2],phonevars[3],phonevars[4],phonevars[5],phonevars[6],phonevars[7],phonevars[8]].get(i))
			phone += "\n"
			phone += "\n"
		#else:
			#print(locks, i+1, locks.has(i+1))

func realtimer():
	realtimetime += 1
	if g.playerpos == "door":
		tick.emit()
	realtimetick = 0

func ticker():
	timeup = 1

func cash():
	itemtype = ["books", "laundry", "dishes"][randi()%3]
	var money = lvl
	print(money,reward, reward[money], time,targettime[money], targettime)
	earned.set(money,reward[money]*min(1.0,targettime[money]/time))

func timer():
	time +=1
	longest = 0
