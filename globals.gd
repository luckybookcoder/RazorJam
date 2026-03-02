extends Node
@warning_ignore("unused_signal")
signal tick
signal move
signal lock
var text = []
var longest = 12
var tickwait = false
var newposses = []
var playerpos = &"box"
var locked = 0
var pointer = 0
var focus
var waiter = false
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta: float) -> void:
	#if not tickwait:
		#tickwait = true
		#await wait(.4)
		#tick.emit()
		#tickwait = false
	await get_node("/root/Main/posswap").button_down
	await get_node("/root/Main/posswap").button_up
	if playerpos == &"box":
		if not waiter:
			playerpos = &"door"
			move.emit()
			var rand = [1,2,3,4,5,6,7,8,9]
			rand.shuffle()
			var a = rand.pop_front()
			var b = rand.pop_front()
			var c = rand.pop_front()
			lock.emit(a,b,c)
			locked = 1
	elif not locked:
		print(playerpos)
		waiter = true
		playerpos = &"box"
		print(playerpos)

func wait(time):
	await get_tree().create_timer(time).timeout
