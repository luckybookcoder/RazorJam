extends Node
@warning_ignore_start("unused_signal")
signal endlvl
signal tick
signal lvltext
signal move
signal lock
var lvlitems = {1:load("lvl1.tscn"), 2:load("res://lvl2.tscn"), 3:load("res://lvl4.tscn")}
var lvleditem
var ticksleft = 0
var text = []
var held = ""
var oldtime = 0
var lockposses = [Vector2(6,0)]
var lastmoves = []
var itemtype = "books"
var lvl = 1
var targettime = 30
var goals = 0
var money = 0
var reward = {1:100}
var longest = 12
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
# Called when the node enters the scene tree for the first time.
func _ready():
	tick.connect(ticker)
# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	if timeup:
		timeup = 0
		timer()
	await get_node("/root/Main/Canla/posswap").button_down
	await get_node("/root/Main/Canla/posswap").button_up
	if playerpos == &"box":
		if not waiter:
			playerpos = &"door"
			move.emit()
			var rand = [1,2,3,4,5,6,7,8,9]
			#rand.shuffle()
			var a = rand.pop_front()
			var b = rand.pop_front()
			var c = rand.pop_front()
			lock.emit(a,b,c)
			print([a,b,c].has(1))
			locked = 3
	elif not locked:
		print(playerpos)
		waiter = true
		playerpos = &"box"
		focus = null
		print(playerpos)

func wait(sec:float):
	await get_tree().create_timer(sec).timeout

func ticker():
	timeup = 1

func timer():
	time +=1
